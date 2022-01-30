import 'package:flutter/cupertino.dart';

String? validateEmail(String? formEmail){
  if(formEmail == null || formEmail.isEmpty) return "Enter data";
  String pattern = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(pattern);
  if(!regex.hasMatch(formEmail)) return 'Invalid Email address format';
  return null;
}


String? validatePassword(String? formPassword){
  if(formPassword == null || formPassword.isEmpty) return "Enter data";
  String pattern = r'^.{6,}$';
  RegExp regex = RegExp(pattern);
  if(!regex.hasMatch(formPassword)) return 'Password must be at least 6 characters';
  return null;
}


final userAlredyRegister = Container(
    padding: const EdgeInsets.all(20),
    alignment: Alignment.center,
    height: 200,
    child: const Text(
      'Пользователь уже зарегестрирован',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
    )
);



final authError = Container(
    padding: const EdgeInsets.all(20),
    alignment: Alignment.center,
    height: 200,
    child: const Text(
      'Пользователь не зарегестрирован или введён неверный пароль',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
    )
);

