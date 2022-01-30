import 'package:authorization_with_bloc/auth/login_event.dart';
import 'package:authorization_with_bloc/auth/login_state.dart';
import 'package:authorization_with_bloc/auth/auth_service.dart';
import 'package:authorization_with_bloc/auth/form_submission_status.dart';
import 'package:authorization_with_bloc/auth/my_user.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';





class LoginBloc extends Bloc<AuthEvent, LoginState>{
  final AuthService authService;
  final MyUser _myUser = MyUser();

  LoginBloc({required this.authService}) : super(LoginState()){
    on<AuthEvent>(_onEvent);
  }



  Future<void> _onEvent(AuthEvent event, Emitter<LoginState> emit) async{

    if(event is EmailField) {
      emit(state.copyWith(email: event.email.toString()));
    }

    else if(event is PasswordField){
      emit(state.copyWith(password: event.password.toString()));
    }

    if(event is Entrance){
      emit(state.copyWith(formSubmissionStatus: const FormSubmittingAuth()));
      var user = await authService.signIn(state.email, state.password);
      if(user == null){
        emit(state.copyWith(formSubmissionStatus: const SubmissionFailed()));
        emit(state.copyWith(formSubmissionStatus: const InitialFormStatus()));
      }
      else{
        emit(state.copyWith(formSubmissionStatus: const SubmissionSuccess()));
      }
    }

    else if(event is Registration){
      emit(state.copyWith(formSubmissionStatus: const FormSubmittingReg()));
      var user = await authService.register(state.email, state.password);
      if(user == null){
        emit(state.copyWith(formSubmissionStatus: const RegistrationFailed()));
        emit(state.copyWith(formSubmissionStatus: const InitialFormStatus()));
      }
      else{
        _myUser.email = state.email;
        _myUser.password = state.password;
        await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set(_myUser.toJson());
        emit(state.copyWith(formSubmissionStatus: const SubmissionSuccess()));
      }
    }


    else if(event is Logout){
      await authService.signOut();
      emit(state.copyWith(formSubmissionStatus: const LogoutSuccess()));
    }


  }
}