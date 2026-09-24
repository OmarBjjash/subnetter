import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_colors_extension.dart';
import '../../../../core/theme/app_spacing.dart';

class IpOctetInput extends StatefulWidget {
  final String? initialValue;
  final ValueChanged<String> onChanged;
  final VoidCallback? onSubmitted;

  /// Increment this from the parent to force the widget to reset
  /// its internal controllers back to [initialValue].
  final int resetSignal;

  const IpOctetInput({
    super.key,
    this.initialValue,
    required this.onChanged,
    this.onSubmitted,
    this.resetSignal = 0,
  });

  @override
  State<IpOctetInput> createState() => _IpOctetInputState();
}

class _IpOctetInputState extends State<IpOctetInput> {
  late final List<TextEditingController> _ctrls;
  late final List<FocusNode> _nodes;
  bool _suppressAutoAdvance = false;

  @override
  void initState() {
    super.initState();
    _ctrls = List.generate(4, (_) => TextEditingController());
    _nodes = List.generate(4, (_) => FocusNode());
    _loadFromInitial();
  }

  @override
  void didUpdateWidget(covariant IpOctetInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.resetSignal != widget.resetSignal) {
      _loadFromInitial();
    }
  }

  void _loadFromInitial() {
    final parts = (widget.initialValue ?? '').split('.');
    for (var i = 0; i < 4; i++) {
      _ctrls[i].text = (i < parts.length) ? parts[i] : '';
    }
  }

  @override
  void dispose() {
    for (final c in _ctrls) {
      c.dispose();
    }
    for (final n in _nodes) {
      n.dispose();
    }
    super.dispose();
  }

  String get _fullIp =>
      _ctrls.map((c) => c.text.isEmpty ? '0' : c.text).join('.');

  void _notify() => widget.onChanged(_fullIp);

  void _focusAt(int i) {
    _nodes[i].requestFocus();
    final t = _ctrls[i].text;
    _ctrls[i].selection = TextSelection.collapsed(offset: t.length);
  }

  void _advance(int from) {
    if (from < 3) {
      _focusAt(from + 1);
    } else {
      FocusScope.of(context).unfocus();
    }
  }

  void _retreat(int from) {
    if (from > 0) _focusAt(from - 1);
  }

  Future<void> _handlePaste(int _) async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    final raw = data?.text?.trim();
    if (raw == null || raw.isEmpty) return;

    final ipPart = raw.split('/').first.trim();
    final octets = ipPart.split('.');
    if (octets.length != 4) return;

    final valid = octets.every((o) {
      final n = int.tryParse(o);
      return n != null && n >= 0 && n <= 255;
    });
    if (!valid) return;

    _suppressAutoAdvance = true;
    setState(() {
      for (var i = 0; i < 4; i++) {
        _ctrls[i].text = octets[i];
      }
    });
    _suppressAutoAdvance = false;

    _notify();
    _focusAt(3);
  }

  @override
  Widget build(BuildContext context) {
    final ext = context.ext;
    final dotStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
      color: ext.textMuted,
      fontFamily: 'monospace',
      fontWeight: FontWeight.w600,
    );

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        children: [
          for (var i = 0; i < 4; i++) ...[
            Expanded(
              key: ValueKey('octet_field_$i'),
              child: _buildField(i, ext),
            ),
            if (i < 3)
              Padding(
                key: ValueKey('octet_dot_$i'),
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                child: Text('.', style: dotStyle),
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildField(int i, AppColorsExtension ext) {
    return Focus(
      onKeyEvent: (node, event) {
        if (event is! KeyDownEvent && event is! KeyRepeatEvent) {
          return KeyEventResult.ignored;
        }

        if (event is KeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.keyV &&
            (HardwareKeyboard.instance.isControlPressed ||
                HardwareKeyboard.instance.isMetaPressed)) {
          _handlePaste(i);
          return KeyEventResult.handled;
        }

        if (event.logicalKey == LogicalKeyboardKey.period ||
            event.logicalKey == LogicalKeyboardKey.numpadDecimal) {
          _advance(i);
          return KeyEventResult.handled;
        }

        if (event.logicalKey == LogicalKeyboardKey.backspace &&
            _ctrls[i].text.isEmpty) {
          _retreat(i);
          return KeyEventResult.handled;
        }

        return KeyEventResult.ignored;
      },
      child: TextField(
        controller: _ctrls[i],
        focusNode: _nodes[i],
        textAlign: TextAlign.center,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        textInputAction: i < 3 ? TextInputAction.next : TextInputAction.done,
        maxLength: 3,
        inputFormatters: [_OctetFormatter(onDotPressed: () => _advance(i))],
        decoration: const InputDecoration(
          counterText: '',
          hintText: '000',
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.md,
          ),
        ),
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontFamily: 'monospace',
          fontWeight: FontWeight.w600,
          letterSpacing: 1.0,
        ),
        onChanged: (v) {
          if (!_suppressAutoAdvance && v.length >= 3) _advance(i);
          _notify();
        },
        onSubmitted: (_) => i < 3 ? _advance(i) : widget.onSubmitted?.call(),
      ),
    );
  }
}

class _OctetFormatter extends TextInputFormatter {
  final VoidCallback? onDotPressed;
  _OctetFormatter({this.onDotPressed});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final t = newValue.text;
    if (t.isEmpty) return newValue;

    if (t.contains('.')) {
      final cb = onDotPressed;
      if (cb != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) => cb());
      }
      final cleaned = t.replaceAll('.', '');
      return TextEditingValue(
        text: cleaned,
        selection: TextSelection.collapsed(offset: cleaned.length),
      );
    }

    if (t.length > 3) return oldValue;
    if (!RegExp(r'^\d{1,3}$').hasMatch(t)) return oldValue;
    final n = int.tryParse(t);
    if (n == null || n > 255) return oldValue;
    return newValue;
  }
}
