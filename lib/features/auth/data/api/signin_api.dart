import 'dart:convert';

import 'package:ecommerce_app/core/errors/app_exception.dart';
import 'package:ecommerce_app/core/errors/failure.dart';
import 'package:ecommerce_app/core/errors/safe_api_call.dart';
import 'package:ecommerce_app/core/network/app_apis.dart';
import 'package:ecommerce_app/features/auth/data/models/request_dto/signin_request_dto.dart';
import 'package:ecommerce_app/features/auth/data/models/response_dto/signin_response_dto.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@LazySingleton()
class SigninApi {
  Future<AppResult<SigninResponseDto>> login(SigninRequestDto request) {
    return safeApiCall(() async {
      final url = Uri.parse('${AppApis.baseUrl}${AppApis.login}');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 401) {
        throw const AuthFailure();
      }
      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw ServerException(
          statusCode: response.statusCode,
          responseBody: response.body,
        );
      }

      final json = jsonDecode(response.body);
      return SigninResponseDto.fromJson(json);
    });
  }
}
