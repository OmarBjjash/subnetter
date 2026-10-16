import 'dart:math' as math;

import 'package:subnetter/features/subnet/domain/entities/cidr_info.dart';

import '../../../../core/errors/app_error.dart';
import '../../../../core/utils/ip_utils.dart';
import '../entities/subnet.dart';
import '../entities/subnet_result.dart';

class CalculateSubnetsUseCase {
  SubnetResult call({
    required String cidr,
    required int count,
    required SubnetMode mode,
  }) {
    final parsed = parseCidr(cidr);
    if (count < 1) throw const AppException(AppError.subnetCountTooSmall);

    final subnets = mode == SubnetMode.equalSize
        ? _equalSize(parsed.ip, parsed.prefix, count)
        : _vlsm(parsed.ip, parsed.prefix, count);

    final note = mode == SubnetMode.equalSize && (count & (count - 1)) != 0
        ? 'Rounded up to next power of 2; ${subnets.length - count} subnet(s) unused.'
        : null;

    return SubnetResult(
      inputCidr: cidr,
      requestedCount: count,
      mode: mode,
      subnets: mode == SubnetMode.equalSize
          ? subnets.take(count).toList()
          : subnets,
      note: note,
    );
  }

  List<Subnet> _equalSize(String ip, int prefix, int count) {
    final bits = (math.log(count) / math.ln2).ceil();
    final newPrefix = prefix + bits;
    if (newPrefix > 32) throw const AppException(AppError.tooManySubnets);
    final blockSize = 1 << (32 - newPrefix);
    final base = Ipv4.toInt(ip) & _mask(prefix);
    return List.generate(
      1 << bits,
      (i) => _build(base + i * blockSize, newPrefix),
    );
  }

  List<Subnet> _vlsm(String ip, int prefix, int count) {
    final base = Ipv4.toInt(ip) & _mask(prefix);
    final out = <Subnet>[];
    _split(base, prefix, count, out);
    return out;
  }

  void _split(int base, int prefix, int count, List<Subnet> out) {
    if (count == 1) {
      out.add(_build(base, prefix));
      return;
    }
    if (prefix >= 32) {
      out.add(_build(base, prefix));
      return;
    }
    final newPrefix = prefix + 1;
    final half = 1 << (32 - newPrefix);
    final left = count ~/ 2 + count % 2;
    final right = count - left;
    _split(base, newPrefix, left, out);
    _split(base + half, newPrefix, right, out);
  }

  int _mask(int prefix) =>
      prefix == 0 ? 0 : (0xFFFFFFFF << (32 - prefix)) & 0xFFFFFFFF;

  Subnet _build(int network, int prefix) {
    final block = prefix == 32 ? 1 : (1 << (32 - prefix));
    final broadcast = network + block - 1;
    final total = block;
    final usable = prefix >= 31 ? 0 : total - 2;
    return Subnet(
      cidr: '${Ipv4.fromInt(network)}/$prefix',
      networkAddress: Ipv4.fromInt(network),
      broadcast: Ipv4.fromInt(broadcast),
      firstUsable: usable > 0 ? Ipv4.fromInt(network + 1) : '—',
      lastUsable: usable > 0 ? Ipv4.fromInt(broadcast - 1) : '—',
      netmask: Ipv4.netmask(prefix),
      wildcard: Ipv4.wildcard(prefix),
      prefixLength: prefix,
      totalAddresses: total,
      usableHosts: usable,
    );
  }
}

class CalculateCidrUseCase {
  CidrInfo call(String cidr) {
    final p = parseCidr(cidr);
    final network = Ipv4.toInt(p.ip) & _mask(p.prefix);
    final block = p.prefix == 32 ? 1 : (1 << (32 - p.prefix));
    final broadcast = network + block - 1;
    final usable = p.prefix >= 31 ? 0 : block - 2;
    return CidrInfo(
      cidr: cidr,
      ip: p.ip,
      prefixLength: p.prefix,
      networkAddress: Ipv4.fromInt(network),
      broadcast: Ipv4.fromInt(broadcast),
      firstUsable: usable > 0 ? Ipv4.fromInt(network + 1) : '—',
      lastUsable: usable > 0 ? Ipv4.fromInt(broadcast - 1) : '—',
      netmask: Ipv4.netmask(p.prefix),
      wildcard: Ipv4.wildcard(p.prefix),
      totalAddresses: block,
      usableAddresses: usable,
      isPrivate: Ipv4.isPrivate(p.ip),
      ipClass: Ipv4.ipClass(p.ip),
    );
  }

  int _mask(int prefix) =>
      prefix == 0 ? 0 : (0xFFFFFFFF << (32 - prefix)) & 0xFFFFFFFF;
}
