import 'package:archive_secure/data/dashboard/data/dashboard_models.dart';
import 'package:archive_secure/data/dashboard/data/dashboard_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardState {
  final DashboardStatus status;
  final DashboardMainModel? data;
  final String? error;

  const DashboardState({
    this.status = DashboardStatus.initial,
    this.data,
    this.error,
  });

  DashboardState copyWith({
    DashboardStatus? status,
    DashboardMainModel? data,
    String? error,
  }) {
    return DashboardState(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error,
    );
  }
}

enum DashboardStatus { initial, loading, success, error }

class DashboardCubit extends Cubit<DashboardState> {
  final DashboardService _service;

  DashboardCubit(this._service) : super(const DashboardState());

  Future<void> load() async {
    emit(state.copyWith(status: DashboardStatus.loading));
    try {
      final data = await _service.getMain();
      emit(state.copyWith(status: DashboardStatus.success, data: data));
    } catch (e) {
      final msg = e.toString().contains('SocketException')
          ? 'No se pudo conectar con el servidor'
          : 'Error al cargar el dashboard';
      emit(state.copyWith(status: DashboardStatus.error, error: msg));
    }
  }
}