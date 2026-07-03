import 'package:archive_secure/data/models/credential_model.dart';
import 'package:archive_secure/domain/entities/pagination_entity.dart';

class PaginationModel {
  final int page;
  final int limit;
  final int total;
  final int totalPages;

  const PaginationModel({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      page: (json['page'] as num?)?.toInt() ?? 1,
      limit: (json['limit'] as num?)?.toInt() ?? 10,
      total: (json['total'] as num?)?.toInt() ?? 0,
      totalPages: (json['totalPages'] as num?)?.toInt() ?? 0,
    );
  }

  PaginationEntity toEntity() {
    return PaginationEntity(
      page: page,
      limit: limit,
      total: total,
      totalPages: totalPages,
    );
  }
}

class FavoriteCredentialsResponseModel {
  final List<CredentialModel> items;
  final PaginationModel pagination;

  const FavoriteCredentialsResponseModel({
    required this.items,
    required this.pagination,
  });

  factory FavoriteCredentialsResponseModel.fromJson(Map<String, dynamic> json) {
    return FavoriteCredentialsResponseModel(
      items: (json['items'] as List<dynamic>)
          .map((e) => CredentialModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: PaginationModel.fromJson(
          json['pagination'] as Map<String, dynamic>),
    );
  }
}
