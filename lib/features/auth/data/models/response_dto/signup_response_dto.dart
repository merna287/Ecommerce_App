import 'package:ecommerce_app/features/auth/domain/entities/response_entities/signup_response_entity.dart';

class SignupResponseDto {
  final int? id;
  final String? email;
  final String? password;
  final String? name;
  final String? role;
  final String? avatar;
  final String? creationAt;
  final String? updatedAt;

  const SignupResponseDto({
    this.id,
    this.email,
    this.password,
    this.name,
    this.role,
    this.avatar,
    this.creationAt,
    this.updatedAt,
  });

  factory SignupResponseDto.fromJson(Map<String, dynamic> json) {
    return SignupResponseDto(
      id: json['id'] as int?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      name: json['name'] as String?,
      role: json['role'] as String?,
      avatar: json['avatar'] as String?,
      creationAt: json['creationAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }

  SignupResponseEntity toEntity() => SignupResponseEntity(
    id: id ?? 0,
    email: email ?? '',
    password: password ?? '',
    name: name ?? '',
    role: role ?? '',
    avatar: avatar ?? '',
  );
}
