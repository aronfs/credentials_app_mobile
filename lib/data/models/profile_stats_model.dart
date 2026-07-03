import 'package:archive_secure/domain/entities/profile_stats_entity.dart';

class ProfileStatsModel {
  final int totalCredentials;
  final int totalCategories;
  final int totalFavorites;

  const ProfileStatsModel({
    required this.totalCredentials,
    required this.totalCategories,
    required this.totalFavorites,
  });

  factory ProfileStatsModel.fromJson(Map<String, dynamic> json) {
    return ProfileStatsModel(
      totalCredentials: (json['totalCredentials'] as num?)?.toInt() ?? 0,
      totalCategories: (json['totalCategories'] as num?)?.toInt() ?? 0,
      totalFavorites: (json['totalFavorites'] as num?)?.toInt() ?? 0,
    );
  }

  ProfileStatsEntity toEntity() {
    return ProfileStatsEntity(
      totalCredentials: totalCredentials,
      totalCategories: totalCategories,
      totalFavorites: totalFavorites,
    );
  }
}
