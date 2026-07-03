import 'package:archive_secure/domain/usecases/get_dashboard_usecase.dart';
import 'package:archive_secure/presentation/dashboard/bloc/dashboard_event.dart';
import 'package:archive_secure/presentation/dashboard/bloc/dashboard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetDashboardUseCase _getDashboardUseCase;

  DashboardBloc({required GetDashboardUseCase getDashboardUseCase})
      : _getDashboardUseCase = getDashboardUseCase,
        super(const DashboardInitial()) {
    on<DashboardRequested>(_onDashboardRequested);
    on<DashboardRefreshed>(_onDashboardRefreshed);
  }

  Future<void> _onDashboardRequested(
    DashboardRequested event,
    Emitter<DashboardState> emit,
  ) async {
    emit(const DashboardLoading());
    await _fetchDashboard(emit);
  }

  Future<void> _onDashboardRefreshed(
    DashboardRefreshed event,
    Emitter<DashboardState> emit,
  ) async {
    await _fetchDashboard(emit);
  }

  Future<void> _fetchDashboard(Emitter<DashboardState> emit) async {
    try {
      final dashboard = await _getDashboardUseCase.call();
      emit(DashboardLoaded(dashboard));
    } catch (e) {
      emit(DashboardFailure(_formatError(e)));
    }
  }

  String _formatError(Object e) {
    final message = e.toString();
    if (message.contains('403')) return 'No tienes permiso para esta acción';
    if (message.contains('404')) return 'Dashboard no encontrado';
    if (message.contains('SocketException') ||
        message.contains('Connection refused')) {
      return 'No se pudo conectar con el servidor';
    }
    return 'Error al cargar el dashboard. Intente de nuevo.';
  }
}
