import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/app_error.dart';
import '../../domain/entities/cidr_info.dart';
import '../../domain/usecases/calculate_subnets.dart';

class CidrState extends Equatable {
  final String input;
  final CidrInfo? info;
  final AppError? error;
  const CidrState({this.input = '192.168.0.0/24', this.info, this.error});

  CidrState copyWith({String? input, CidrInfo? info, AppError? error}) =>
      CidrState(
        input: input ?? this.input,
        info: info ?? this.info,
        error: error,
      );

  @override
  List<Object?> get props => [input, info, error];
}

class CidrCubit extends Cubit<CidrState> {
  final CalculateCidrUseCase _calc;
  CidrCubit(this._calc) : super(const CidrState());

  void setInput(String v) => emit(state.copyWith(input: v, error: null));

  void reset() {
    emit(const CidrState()); // back to default 192.168.0.0/24
  }

  void calculate() {
    try {
      final info = _calc(state.input);
      emit(state.copyWith(info: info, error: null));
    } on AppException catch (e) {
      emit(state.copyWith(error: e.error));
    } catch (_) {
      emit(state.copyWith(error: AppError.unknown));
    }
  }
}
