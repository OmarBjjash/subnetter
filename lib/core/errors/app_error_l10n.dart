import '../../l10n/app_localizations.dart';
import 'app_error.dart';

/// Renders an [AppError] in the active locale.
extension AppErrorL10n on AppError {
  String message(AppLocalizations l10n) => switch (this) {
    AppError.invalidIpv4 => l10n.invalidIPv4,
    AppError.invalidOctet => l10n.invalidOctet,
    AppError.missingPrefix => l10n.missingPrefix,
    AppError.prefixOutOfRange => l10n.prefixOutOfRange,
    AppError.subnetCountTooSmall => l10n.subnetCountError,
    AppError.tooManySubnets => l10n.tooManySubnets,
    AppError.unknown => l10n.unexpectedError,
  };
}
