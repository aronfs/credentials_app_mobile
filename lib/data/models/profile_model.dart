import 'package:archive_secure/data/models/profile_stats_model.dart';
import 'package:archive_secure/data/models/profile_user_model.dart';
import 'package:archive_secure/domain/entities/profile_entity.dart';

class ProfileModel {
  final ProfileUserModel user;
  final ProfileStatsModel stats;

  const ProfileModel({required this.user, required this.stats});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      user: ProfileUserModel.fromJson(json['user'] as Map<String, dynamic>),
      stats: ProfileStatsModel.fromJson(json['stats'] as Map<String, dynamic>),
    );
  }

  ProfileEntity toEntity() {
    return ProfileEntity(
      user: user.toEntity(),
      stats: stats.toEntity(),
    );
  }
}
