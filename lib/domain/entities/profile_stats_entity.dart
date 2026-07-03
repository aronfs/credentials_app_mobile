import 'package:equatable/equatable.dart';

class ProfileStatsEntity extends Equatable {
  final int totalCredentials;
  final int totalCategories;
  final int totalFavorites;

  const ProfileStatsEntity({
    required this.totalCredentials,
    required this.totalCategories,
    required this.totalFavorites,
  });

  @override
  List<Object?> get props => [totalCredentials, totalCategories, totalFavorites];
}
