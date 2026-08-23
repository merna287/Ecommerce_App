import 'dart:convert';

import 'package:ecommerce_app/core/errors/app_exception.dart';
import 'package:ecommerce_app/core/errors/failure.dart';
import 'package:ecommerce_app/core/errors/safe_api_call.dart';
import 'package:ecommerce_app/core/network/app_apis.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@LazySingleton()
class UserAvailabilityApi {
  Future<AppResult<bool>> isAvailable(String email) {
    return safeApiCall(() async {
      final url = Uri.parse('${AppApis.baseUrl}${AppApis.checkUserAvailable}');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw ServerException(
          statusCode: response.statusCode,
          responseBody: response.body,
        );
      }

      final json = jsonDecode(response.body);
      return json['isAvailable'] == true;
    });
  }
}
