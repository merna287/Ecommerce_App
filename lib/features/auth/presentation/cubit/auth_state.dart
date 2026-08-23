import 'package:ecommerce_app/features/auth/domain/entities/response_entities/signin_response_entity.dart';

sealed class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthSuccess extends AuthState {
  final SigninResponseEntity? session;

  const AuthSuccess({this.session});
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);
}
