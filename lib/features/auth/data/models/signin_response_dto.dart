import 'package:ecommerce_app/features/auth/domain/entities/response_entities/signin_response_entity.dart';

class SigninResponseDto {
  final String? accessToken;
  final String? refreshToken;

  const SigninResponseDto({
    required this.accessToken,
    required this.refreshToken,
  });

  factory SigninResponseDto.fromJson(Map<String, dynamic> json) {
    return SigninResponseDto(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }

  SigninResponseEntity toEntity() => SigninResponseEntity(
    accessToken: accessToken ?? '',
    refreshToken: refreshToken ?? '',
  );
}