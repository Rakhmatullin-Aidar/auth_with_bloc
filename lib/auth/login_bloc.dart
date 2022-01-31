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
      try{
        emit(state.copyWith(formSubmissionStatus: const FormSubmittingAuth()));
        await authService.signIn(state.email, state.password);
        emit(state.copyWith(formSubmissionStatus: const SubmissionSuccess()));
        emit(state.copyWith(formSubmissionStatus: const InitialFormStatus()));
      }on FirebaseAuthException catch(e){
        emit(state.copyWith(message: e.message));
        emit(state.copyWith(formSubmissionStatus: const SubmissionFailed()));
      }
    }


    else if(event is Registration){
      emit(state.copyWith(formSubmissionStatus: const FormSubmittingReg()));
      try{
        await authService.register(state.email, state.password);
        _myUser.email = state.email;
        _myUser.password = state.password;
        await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set(_myUser.toJson());
        emit(state.copyWith(formSubmissionStatus: const SubmissionSuccess()));
        emit(state.copyWith(formSubmissionStatus: const InitialFormStatus()));
      }on FirebaseAuthException catch(e){
        emit(state.copyWith(message: e.message));
        emit(state.copyWith(formSubmissionStatus: const RegistrationFailed()));
      }
    }


    else if(event is CloseErrorWindow){
      emit(state.copyWith(formSubmissionStatus: const InitialFormStatus()));
    }


    else if(event is Logout){
      await authService.signOut();
      emit(state.copyWith(formSubmissionStatus: const LogoutSuccess()));
    }


  }
}