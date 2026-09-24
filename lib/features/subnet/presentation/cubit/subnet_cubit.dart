import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/subnet_result.dart';
import '../../domain/usecases/calculate_subnets.dart';

class SubnetState extends Equatable {
  final String cidr;
  final int count;
  final SubnetMode mode;
  final SubnetResult? result;
  final String? error;

  const SubnetState({
    this.cidr = '192.168.0.0/24',
    this.count = 3,
    this.mode = SubnetMode.equalSize,
    this.result,
    this.error,
  });

  SubnetState copyWith({
    String? cidr,
    int? count,
    SubnetMode? mode,
    SubnetResult? result,
    String? error,
  }) => SubnetState(
    cidr: cidr ?? this.cidr,
    count: count ?? this.count,
    mode: mode ?? this.mode,
    result: result ?? this.result,
    error: error,
  );

  @override
  List<Object?> get props => [cidr, count, mode, result, error];
}

class SubnetCubit extends Cubit<SubnetState> {
  final CalculateSubnetsUseCase _calc;
  SubnetCubit(this._calc) : super(const SubnetState());

  void setCidr(String v) => emit(state.copyWith(cidr: v, error: null));
  void setCount(int v) => emit(state.copyWith(count: v, error: null));
  void setMode(SubnetMode m) => emit(state.copyWith(mode: m, error: null));

  void reset() {
    emit(
      const SubnetState(),
    ); // back to defaults (192.168.0.0/24, 3, equalSize)
  }

  void calculate() {
    try {
      final r = _calc(cidr: state.cidr, count: state.count, mode: state.mode);
      emit(state.copyWith(result: r, error: null));
    } catch (e) {
      emit(
        state.copyWith(
          error: e.toString().replaceFirst('FormatException: ', ''),
        ),
      );
    }
  }
}
