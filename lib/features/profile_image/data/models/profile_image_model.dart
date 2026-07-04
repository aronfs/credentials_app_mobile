import 'package:archive_secure/features/profile_image/domain/entities/profile_image_entity.dart';

class ProfileImageModel {
  final String id;
  final String fileName;
  final String filePath;
  final String fileUrl;
  final String mimeType;
  final int fileSize;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ProfileImageModel({
    required this.id,
    required this.fileName,
    required this.filePath,
    required this.fileUrl,
    required this.mimeType,
    required this.fileSize,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProfileImageModel.fromJson(Map<String, dynamic> json) {
    return ProfileImageModel(
      id: json['id'] as String,
      fileName: json['fileName'] as String,
      filePath: json['filePath'] as String,
      fileUrl: json['fileUrl'] as String,
      mimeType: json['mimeType'] as String,
      fileSize: json['fileSize'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fileName': fileName,
      'filePath': filePath,
      'fileUrl': fileUrl,
      'mimeType': mimeType,
      'fileSize': fileSize,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  ProfileImageEntity toEntity() {
    return ProfileImageEntity(
      id: id,
      fileName: fileName,
      filePath: filePath,
      fileUrl: fileUrl,
      mimeType: mimeType,
      fileSize: fileSize,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
