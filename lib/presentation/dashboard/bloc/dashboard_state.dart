import 'package:archive_secure/domain/entities/dashboard_entity.dart';
import 'package:equatable/equatable.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {
  const DashboardInitial();
}

class DashboardLoading extends DashboardState {
  const DashboardLoading();
}

class DashboardLoaded extends DashboardState {
  final DashboardEntity data;

  const DashboardLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class DashboardFailure extends DashboardState {
  final String error;

  const DashboardFailure(this.error);

  @override
  List<Object?> get props => [error];
}
