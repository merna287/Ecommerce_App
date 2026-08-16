class SigninRequestDto {
  String? email;
  String? password;

  SigninRequestDto({this.email, this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['email'] = email;
    data['password'] = password;
    return data;
  }

  SigninRequestDto.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }
}
