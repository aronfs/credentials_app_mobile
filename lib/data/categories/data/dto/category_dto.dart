class CreateCategoryDto {
  final String name;
  final String color;
  final String icon;

  CreateCategoryDto({
    required this.name,
    required this.color,
    required this.icon,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'color': color,
        'icon': icon,
      };
}

class UpdateCategoryDto {
  final String? name;
  final String? color;
  final String? icon;
  final bool? isActive;

  UpdateCategoryDto({
    this.name,
    this.color,
    this.icon,
    this.isActive,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (name != null) map['name'] = name;
    if (color != null) map['color'] = color;
    if (icon != null) map['icon'] = icon;
    if (isActive != null) map['isActive'] = isActive;
    return map;
  }
}

class CategoryResponseDto {
  final String id;
  final String userId;
  final String name;
  final String color;
  final String icon;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int totalCredentials;

  CategoryResponseDto({
    required this.id,
    required this.userId,
    required this.name,
    required this.color,
    required this.icon,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.totalCredentials = 0,
  });

  factory CategoryResponseDto.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    if (data is List) {
      throw Exception('Expected single object but got list');
    }
    final map = data as Map<String, dynamic>;
    return CategoryResponseDto(
      id: map['id'] as String,
      userId: map['userId'] as String,
      name: map['name'] as String,
      color: map['color'] as String,
      icon: map['icon'] as String,
      isActive: map['isActive'] as bool,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
      totalCredentials: (map['totalCredentials'] as num?)?.toInt() ?? 0,
    );
  }
}
