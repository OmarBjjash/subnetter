import 'package:equatable/equatable.dart';

class CidrInfo extends Equatable {
  final String cidr;
  final String ip;
  final int prefixLength;
  final String networkAddress;
  final String broadcast;
  final String firstUsable;
  final String lastUsable;
  final String netmask;
  final String wildcard;
  final int totalAddresses;
  final int usableAddresses;
  final bool isPrivate;
  final String ipClass;

  const CidrInfo({
    required this.cidr, required this.ip, required this.prefixLength,
    required this.networkAddress, required this.broadcast,
    required this.firstUsable, required this.lastUsable,
    required this.netmask, required this.wildcard,
    required this.totalAddresses, required this.usableAddresses,
    required this.isPrivate, required this.ipClass,
  });

  @override
  List<Object?> get props => [cidr, ip, prefixLength];
}