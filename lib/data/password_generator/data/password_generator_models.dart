class PasswordGeneratedModel {
  final String password;
  final int length;
  final String strength;
  final int score;

  PasswordGeneratedModel({
    required this.password,
    required this.length,
    required this.strength,
    required this.score,
  });

  factory PasswordGeneratedModel.fromJson(Map<String, dynamic> json) {
    return PasswordGeneratedModel(
      password: json['password'] as String,
      length: json['length'] as int,
      strength: json['strength'] as String,
      score: json['score'] as int,
    );
  }
}

class PasswordEvaluationModel {
  final String strength;
  final int score;
  final List<String> suggestions;

  PasswordEvaluationModel({
    required this.strength,
    required this.score,
    required this.suggestions,
  });

  factory PasswordEvaluationModel.fromJson(Map<String, dynamic> json) {
    return PasswordEvaluationModel(
      strength: json['strength'] as String,
      score: json['score'] as int,
      suggestions: (json['suggestions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );
  }
}