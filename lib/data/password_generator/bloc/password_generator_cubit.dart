import 'package:archive_secure/data/password_generator/data/password_generator_models.dart';
import 'package:archive_secure/data/password_generator/data/password_generator_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordGeneratorState {
  final PasswordGenStatus status;
  final PasswordGeneratedModel? generated;
  final PasswordEvaluationModel? evaluation;
  final String? error;

  const PasswordGeneratorState({
    this.status = PasswordGenStatus.initial,
    this.generated,
    this.evaluation,
    this.error,
  });

  PasswordGeneratorState copyWith({
    PasswordGenStatus? status,
    PasswordGeneratedModel? generated,
    PasswordEvaluationModel? evaluation,
    String? error,
  }) {
    return PasswordGeneratorState(
      status: status ?? this.status,
      generated: generated ?? this.generated,
      evaluation: evaluation ?? this.evaluation,
      error: error,
    );
  }
}

enum PasswordGenStatus { initial, loading, success, evaluationSuccess, error }

class PasswordGeneratorCubit extends Cubit<PasswordGeneratorState> {
  final PasswordGeneratorService _service;

  PasswordGeneratorCubit(this._service) : super(const PasswordGeneratorState());

  Future<void> generate({
    int length = 16,
    bool includeUppercase = true,
    bool includeLowercase = true,
    bool includeNumbers = true,
    bool includeSymbols = true,
    bool excludeSimilarCharacters = false,
  }) async {
    emit(state.copyWith(status: PasswordGenStatus.loading));
    try {
      final result = await _service.generate(
        length: length,
        includeUppercase: includeUppercase,
        includeLowercase: includeLowercase,
        includeNumbers: includeNumbers,
        includeSymbols: includeSymbols,
        excludeSimilarCharacters: excludeSimilarCharacters,
      );
      emit(state.copyWith(status: PasswordGenStatus.success, generated: result));
    } catch (e) {
      emit(state.copyWith(
        status: PasswordGenStatus.error,
        error: 'Error al generar la contraseña',
      ));
    }
  }

  Future<void> evaluate(String password) async {
    emit(state.copyWith(status: PasswordGenStatus.loading));
    try {
      final result = await _service.evaluate(password);
      emit(state.copyWith(status: PasswordGenStatus.evaluationSuccess, evaluation: result));
    } catch (e) {
      emit(state.copyWith(
        status: PasswordGenStatus.error,
        error: 'Error al evaluar la contraseña',
      ));
    }
  }
}