import 'package:equatable/equatable.dart';

class Subnet extends Equatable {
  final String cidr;
  final String networkAddress;
  final String broadcast;
  final String firstUsable;
  final String lastUsable;
  final String netmask;
  final String wildcard;
  final int prefixLength;
  final int totalAddresses;
  final int usableHosts;

  const Subnet({
    required this.cidr,
    required this.networkAddress,
    required this.broadcast,
    required this.firstUsable,
    required this.lastUsable,
    required this.netmask,
    required this.wildcard,
    required this.prefixLength,
    required this.totalAddresses,
    required this.usableHosts,
  });

  @override
  List<Object?> get props => [cidr, networkAddress, broadcast, firstUsable,
    lastUsable, netmask, wildcard, prefixLength, totalAddresses, usableHosts];
}