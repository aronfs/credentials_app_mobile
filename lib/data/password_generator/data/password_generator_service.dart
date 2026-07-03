import 'package:archive_secure/data/password_generator/data/password_generator_models.dart';
import 'package:archive_secure/utils/api_endpoints.dart';
import 'package:dio/dio.dart';
import 'package:archive_secure/core/security/token_storage.dart';

class PasswordGeneratorService {
  final Dio _dio;
  final TokenStorage _tokenStorage;

  PasswordGeneratorService(this._dio, this._tokenStorage);

  Future<String> _getToken() async {
    final token = await _tokenStorage.getAccessToken();
    if (token == null) throw Exception('No authentication token');
    return token;
  }

  Future<PasswordGeneratedModel> generate({
    required int length,
    bool includeUppercase = true,
    bool includeLowercase = true,
    bool includeNumbers = true,
    bool includeSymbols = true,
    bool excludeSimilarCharacters = false,
  }) async {
    final token = await _getToken();
    final response = await _dio.post(
      ApiEndpoints.passwordGenerate,
      data: {
        'length': length,
        'includeUppercase': includeUppercase,
        'includeLowercase': includeLowercase,
        'includeNumbers': includeNumbers,
        'includeSymbols': includeSymbols,
        'excludeSimilarCharacters': excludeSimilarCharacters,
      },
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return PasswordGeneratedModel.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  Future<PasswordEvaluationModel> evaluate(String password) async {
    final token = await _getToken();
    final response = await _dio.post(
      ApiEndpoints.passwordEvaluate,
      data: {'password': password},
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return PasswordEvaluationModel.fromJson(response.data['data'] as Map<String, dynamic>);
  }
}