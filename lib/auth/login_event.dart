import 'package:authorization_with_bloc/auth/form_submission_status.dart';


abstract class AuthEvent {}


class EmailField extends AuthEvent{
  final String email;
  EmailField({required this.email});
}


class PasswordField extends AuthEvent{
  final String password;
  PasswordField({required this.password});
}



class Entrance extends AuthEvent{
  String? email;
  String? password;
  final FormSubmissionStatus? formSibmissionStatus;


  Entrance({this.email,this.password, this.formSibmissionStatus});
}


class Logout extends AuthEvent{}


class CloseErrorWindow extends AuthEvent{}



class Registration extends AuthEvent{
  String? email;
  String? password;

  Registration({this.email,this.password});
}





