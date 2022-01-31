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





