class GoogleSigninRequestEntity {
  final String name;
  final String email;
  final String? photoUrl;
  final String googleSub;

  const GoogleSigninRequestEntity({
    required this.name,
    required this.email,
    this.photoUrl,
    required this.googleSub,
  });
}