class CreateCredentialDto {
  final String serviceName;
  final String? loginEmail;
  final String? username;
  final String password;
  final String? categoryId;
  final String? notes;
  final List<String>? tags;
  final int? strength;

  CreateCredentialDto({
    required this.serviceName,
    this.loginEmail,
    this.username,
    required this.password,
    this.categoryId,
    this.notes,
    this.tags,
    this.strength,
  });

  Map<String, dynamic> toJson() => {
        'serviceName': serviceName,
        if (loginEmail != null) 'loginEmail': loginEmail,
        if (username != null) 'username': username,
        'password': password,
        if (categoryId != null) 'categoryId': categoryId,
        if (notes != null) 'notes': notes,
        if (tags != null) 'tags': tags,
        if (strength != null) 'strength': strength,
      };
}

class UpdateCredentialDto {
  final String? serviceName;
  final String? loginEmail;
  final String? username;
  final String? password;
  final String? categoryId;
  final String? notes;
  final List<String>? tags;
  final int? strength;

  UpdateCredentialDto({
    this.serviceName,
    this.loginEmail,
    this.username,
    this.password,
    this.categoryId,
    this.notes,
    this.tags,
    this.strength,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (serviceName != null) map['serviceName'] = serviceName;
    if (loginEmail != null) map['loginEmail'] = loginEmail;
    if (username != null) map['username'] = username;
    if (password != null) map['password'] = password;
    if (categoryId != null) map['categoryId'] = categoryId;
    if (notes != null) map['notes'] = notes;
    if (tags != null) map['tags'] = tags;
    if (strength != null) map['strength'] = strength;
    return map;
  }
}

class CredentialResponseDto {
  final String id;
  final String userId;
  final String serviceName;
  final String? loginEmail;
  final String? username;
  final String? categoryId;
  final String? notes;
  final List<String> tags;
  final int? strength;
  final bool isFavorite;
  final DateTime? lastUsedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  CredentialResponseDto({
    required this.id,
    required this.userId,
    required this.serviceName,
    this.loginEmail,
    this.username,
    this.categoryId,
    this.notes,
    this.tags = const [],
    this.strength,
    this.isFavorite = false,
    this.lastUsedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CredentialResponseDto.fromMap(Map<String, dynamic> map) {
    return CredentialResponseDto(
      id: map['id'] as String,
      userId: map['userId'] as String,
      serviceName: map['serviceName'] as String,
      loginEmail: map['loginEmail'] as String?,
      username: map['username'] as String?,
      categoryId: map['categoryId'] as String?,
      notes: map['notes'] as String?,
      tags: (map['tags'] as List<dynamic>?)?.cast<String>() ?? [],
      strength: map['strength'] as int?,
      isFavorite: map['isFavorite'] as bool? ?? false,
      lastUsedAt: map['lastUsedAt'] != null
          ? DateTime.parse(map['lastUsedAt'] as String)
          : null,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
    );
  }

  factory CredentialResponseDto.fromJson(Map<String, dynamic> json) {
    return CredentialResponseDto.fromMap(json['data'] as Map<String, dynamic>);
  }
}

class PasswordResponseDto {
  final String credentialId;
  final String serviceName;
  final String? loginEmail;
  final String? username;
  final String password;

  PasswordResponseDto({
    required this.credentialId,
    required this.serviceName,
    this.loginEmail,
    this.username,
    required this.password,
  });

  factory PasswordResponseDto.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    return PasswordResponseDto(
      credentialId: data['credentialId'] as String,
      serviceName: data['serviceName'] as String,
      loginEmail: data['loginEmail'] as String?,
      username: data['username'] as String?,
      password: data['password'] as String,
    );
  }
}
