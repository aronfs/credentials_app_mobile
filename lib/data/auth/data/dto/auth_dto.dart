class AuthDto {
  final String email;
  final String password;

  AuthDto({required this.email, required this.password});

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}

class RegisterDto {
  final String name;
  final String email;
  final String password;
  final String pin;

  RegisterDto({
    required this.name,
    required this.email,
    required this.password,
    required this.pin,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'pin': pin,
      };
}

class LoginResponseDto {
  final String id;
  final String name;
  final String email;
  final String roleId;
  final String accessToken;
  final String refreshToken;

  LoginResponseDto({
    required this.id,
    required this.name,
    required this.email,
    required this.roleId,
    required this.accessToken,
    required this.refreshToken,
  });

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) {
    final user = json['data']['user'];
    return LoginResponseDto(
      id: user['id'] as String,
      name: user['name'] as String,
      email: user['email'] as String,
      roleId: user['roleId'] as String,
      accessToken: json['data']['accessToken'] as String,
      refreshToken: json['data']['refreshToken'] as String,
    );
  }
}

class VerifyPinDto {
  final String pin;

  VerifyPinDto({required this.pin});

  Map<String, dynamic> toJson() => {'pin': pin};
}

class VerifyPinResponseDto {
  final bool isValid;

  VerifyPinResponseDto({required this.isValid});

  factory VerifyPinResponseDto.fromJson(Map<String, dynamic> json) {
    return VerifyPinResponseDto(
      isValid: json['data']['isValid'] as bool,
    );
  }
}

class RefreshTokenDto {
  final String refreshToken;

  RefreshTokenDto({required this.refreshToken});

  Map<String, dynamic> toJson() => {'refreshToken': refreshToken};
}

class RefreshTokenResponseDto {
  final String accessToken;
  final String refreshToken;

  RefreshTokenResponseDto({
    required this.accessToken,
    required this.refreshToken,
  });

  factory RefreshTokenResponseDto.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    return RefreshTokenResponseDto(
      accessToken: data['accessToken'] as String,
      refreshToken: data['refreshToken'] as String,
    );
  }
}
