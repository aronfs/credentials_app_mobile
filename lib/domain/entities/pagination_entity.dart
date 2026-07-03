import 'package:equatable/equatable.dart';

class PaginationEntity extends Equatable {
  final int page;
  final int limit;
  final int total;
  final int totalPages;

  const PaginationEntity({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
  });

  bool get hasNextPage => page < totalPages;

  @override
  List<Object?> get props => [page, limit, total, totalPages];
}
