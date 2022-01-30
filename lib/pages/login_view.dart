import 'package:authorization_with_bloc/auth/login_bloc.dart';
import 'package:authorization_with_bloc/auth/login_event.dart';
import 'package:authorization_with_bloc/auth/auth_service.dart';
import 'package:authorization_with_bloc/auth/form_submission_status.dart';
import 'package:authorization_with_bloc/validation/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../auth/login_state.dart';




class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);


  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auth'),
        centerTitle: true,
      ),
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(authService: context.read<AuthService>()),
        child: _logInForm(context),
      ),
    );
  }





  Widget _logInForm(context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.formSubmissionStatus is SubmissionSuccess){
          _emailController.clear();
          _passwordController.clear();
          Navigator.of(context).pushNamed('/homepage');
        }
        else if(state.formSubmissionStatus is RegistrationFailed){
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context){
              return userAlredyRegister;
            }
          );
        }
        else if(state.formSubmissionStatus is SubmissionFailed){
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context){
                return authError;
              }
          );
        }
      },
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height/4),
                _emailField(),
                _passwordField(),
                const SizedBox(height: 50),
                _logInButton(),
                _registerButton()
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _emailField(){
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state){
      return TextFormField(
        controller: _emailController,
        decoration: const InputDecoration(hintText: 'email'),
        validator: validateEmail,
        onChanged: (value) => context.read<LoginBloc>().add(EmailField(email: value.trim())),
      );
    });
  }


  Widget _passwordField(){
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        controller: _passwordController,
        decoration: const InputDecoration(hintText: 'Password'),
        obscureText: true,
        validator: validatePassword,
        onChanged: (value) => context.read<LoginBloc>().add(PasswordField(password: value.trim())),
      );
    });
  }

  Widget _logInButton(){
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return state.formSubmissionStatus is FormSubmittingAuth ?
        const CircularProgressIndicator() :
        ElevatedButton(
          child: const Text('Login'),
          onPressed: () {
            if(formKey.currentState!.validate()){
              context.read<LoginBloc>().add(Entrance(email: state.email, password: state.password));
            }
          },
      );
    });
  }


  Widget _registerButton(){
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return state.formSubmissionStatus is FormSubmittingReg ?
      const CircularProgressIndicator() :
        ElevatedButton(
          onPressed: () {
            if(formKey.currentState!.validate()){
              context.read<LoginBloc>().add(Registration(email: state.email, password: state.password));
            }
          },
          child: const Text('Registration'),
      );
    });
  }

}
