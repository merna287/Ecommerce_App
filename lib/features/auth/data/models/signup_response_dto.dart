import 'package:ecommerce_app/features/auth/domain/entities/response_entities/signup_response_entity.dart';

class SignupResponseDto {
  int? id;
  String? email;
  String? password;
  String? name;
  String? role;
  String? avatar;
  String? creationAt;
  String? updatedAt;

  SignupResponseDto({
    this.id,
    this.email,
    this.password,
    this.name,
    this.role,
    this.avatar,
    this.creationAt,
    this.updatedAt,
  });

  SignupResponseDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
    name = json['name'];
    role = json['role'];
    avatar = json['avatar'];
    creationAt = json['creationAt'];
    updatedAt = json['updatedAt'];
  }

  SignupResponseEntity toEntity() => SignupResponseEntity(
    id: id = 0,
    email: email = '',
    password: password = '',
    name: name= '',
    role: role= '',
    avatar: avatar = '',
  );
}
