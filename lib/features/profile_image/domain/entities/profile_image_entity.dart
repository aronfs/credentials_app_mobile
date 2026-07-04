import 'package:equatable/equatable.dart';

class ProfileImageEntity extends Equatable {
  final String id;
  final String fileName;
  final String filePath;
  final String fileUrl;
  final String mimeType;
  final int fileSize;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ProfileImageEntity({
    required this.id,
    required this.fileName,
    required this.filePath,
    required this.fileUrl,
    required this.mimeType,
    required this.fileSize,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        fileName,
        filePath,
        fileUrl,
        mimeType,
        fileSize,
        createdAt,
        updatedAt,
      ];
}
