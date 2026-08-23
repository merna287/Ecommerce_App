class SignupResponseEntity {
  final int id;
  final String email;
  final String password;
  final String name;
  final String role;
  final String avatar;

  const SignupResponseEntity({
    this.id = 0,
    this.email = '',
    this.password = '',
    this.name = '',
    this.role = '',
    this.avatar = '',
  });
}
