class SigninResponseEntity {
  final String accessToken;
  final String refreshToken;

  const SigninResponseEntity({
    this.accessToken = '',
    this.refreshToken = '',
  });
}