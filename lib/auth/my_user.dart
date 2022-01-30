class MyUser{
  String? email;
  String? password;

  MyUser({this.email, this.password});

  Map<String, dynamic> toJson() => {'email': email, 'password': password};

}