import 'package:authorization_with_bloc/auth/form_submission_status.dart';


class LoginState{

  final String email;
  final String password;
  final FormSubmissionStatus formSubmissionStatus;
  final String? message;


  LoginState({
    this.email = '',
    this.password = '',
    this.message = '',
    this.formSubmissionStatus = const InitialFormStatus(),
  });

  LoginState copyWith({String? email, String? password, FormSubmissionStatus? formSubmissionStatus, String? message}){
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      formSubmissionStatus: formSubmissionStatus ?? this.formSubmissionStatus,
      message: message ?? this.message,
    );
  }


}
