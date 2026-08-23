class SignupRequestDto {
  String? name;
  String? email;
  String? password;
  String? avatar;

  SignupRequestDto({this.name, this.email, this.password, this.avatar});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['avatar'] = "https://picsum.photos/800";
    return data;
  }

  SignupRequestDto.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
  }
}
