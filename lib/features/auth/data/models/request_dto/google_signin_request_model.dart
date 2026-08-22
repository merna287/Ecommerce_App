import 'package:ecommerce_app/features/auth/domain/entities/request_entities/google_signin_request_entity.dart';

class GoogleSigninRequestDto extends GoogleSigninRequestEntity {
  const GoogleSigninRequestDto({
    required super.name,
    required super.email,
    super.photoUrl,
    required super.googleSub,
  });
}
