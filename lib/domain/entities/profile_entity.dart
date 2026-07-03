import 'package:archive_secure/domain/entities/profile_stats_entity.dart';
import 'package:archive_secure/domain/entities/profile_user_entity.dart';
import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final ProfileUserEntity user;
  final ProfileStatsEntity stats;

  const ProfileEntity({required this.user, required this.stats});

  @override
  List<Object?> get props => [user, stats];
}
