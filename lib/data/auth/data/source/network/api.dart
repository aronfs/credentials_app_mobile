import 'package:archive_secure/data/auth/data/dto/auth_dto.dart';
import 'package:archive_secure/utils/api_endpoints.dart';
import 'package:dio/dio.dart';

abstract class Api {
  Future<LoginResponseDto> login(AuthDto credentials);
  Future<LoginResponseDto> register(RegisterDto data);
  Future<VerifyPinResponseDto> verifyPin(String pin, String token);
  Future<RefreshTokenResponseDto> refreshToken(RefreshTokenDto dto);
  Future<void> logout(String token);
}

class ApiImpl implements Api {
  final Dio _dio;

  ApiImpl(this._dio);

  @override
  Future<LoginResponseDto> login(AuthDto credentials) async {
    final response = await _dio.post(
      ApiEndpoints.login,
      data: credentials.toJson(),
    );
    return LoginResponseDto.fromJson(response.data);
  }

  @override
  Future<LoginResponseDto> register(RegisterDto data) async {
    final response = await _dio.post(
      ApiEndpoints.register,
      data: data.toJson(),
    );
    return LoginResponseDto.fromJson(response.data);
  }

  @override
  Future<VerifyPinResponseDto> verifyPin(String pin, String token) async {
    final response = await _dio.post(
      ApiEndpoints.verifyPin,
      data: VerifyPinDto(pin: pin).toJson(),
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return VerifyPinResponseDto.fromJson(response.data);
  }

  @override
  Future<RefreshTokenResponseDto> refreshToken(RefreshTokenDto dto) async {
    final response = await _dio.post(
      ApiEndpoints.refresh,
      data: dto.toJson(),
    );
    return RefreshTokenResponseDto.fromJson(response.data);
  }

  @override
  Future<void> logout(String token) async {
    await _dio.post(
      ApiEndpoints.logout,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }
}