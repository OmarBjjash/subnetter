import 'package:equatable/equatable.dart';
import 'subnet.dart';

enum SubnetMode { equalSize, vlsm }

class SubnetResult extends Equatable {
  final String inputCidr;
  final int requestedCount;
  final SubnetMode mode;
  final List<Subnet> subnets;
  final String? note;

  const SubnetResult({
    required this.inputCidr,
    required this.requestedCount,
    required this.mode,
    required this.subnets,
    this.note,
  });

  @override
  List<Object?> get props => [inputCidr, requestedCount, mode, subnets, note];
}