import 'dart:convert';

import 'package:ecommerce_app/core/errors/app_exception.dart';
import 'package:ecommerce_app/core/errors/failure.dart';
import 'package:ecommerce_app/core/errors/safe_api_call.dart';
import 'package:ecommerce_app/core/network/app_apis.dart';
import 'package:ecommerce_app/features/auth/data/models/request_dto/signup_request_dto.dart';
import 'package:ecommerce_app/features/auth/data/models/signup_response_dto.dart';
import 'package:http/http.dart' as http;

class SignupApi {
  Future<AppResult<SignupResponseDto>> signup(
    SignupRequestDto request,
  ) {
    return safeApiCall(() async {
      final url = Uri.https(AppApis.baseUrl,AppApis.register,);
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );

      print('STATUS: ${response.statusCode}');
      print('BODY: ${response.body}');

      if (response.statusCode == 400) {
        throw const AuthFailure(
          message: 'Invalid signup data',
        );
      }

      if (response.statusCode < 200 ||
          response.statusCode >= 300) {
        throw ServerException(
          statusCode: response.statusCode,
          responseBody: response.body,
        );
      }

      final json = jsonDecode(response.body);
      return SignupResponseDto.fromJson(json);
    });
  }
}