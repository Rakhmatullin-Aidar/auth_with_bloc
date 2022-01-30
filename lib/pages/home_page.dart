import 'package:authorization_with_bloc/auth/login_event.dart';
import 'package:authorization_with_bloc/auth/login_state.dart';
import 'package:authorization_with_bloc/auth/form_submission_status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../auth/login_bloc.dart';
import '../auth/auth_service.dart';
import '../auth/my_user.dart';



class HomePage extends StatefulWidget{
  const HomePage({Key? key}):super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}



class _HomePageState extends State<HomePage>{


  final MyUser _myUser = MyUser();
  User? user = FirebaseAuth.instance.currentUser;

  Future getUser() async{
    var data = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
    setState(() {
      _myUser.email = data.get('email');
      _myUser.password = data.get('password');
    });
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(authService: context.read<AuthService>()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home page'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            _logOutButton(),
          ],
        ),
        body: BlocBuilder<LoginBloc, LoginState>(builder: (context, state){
          return BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state.formSubmissionStatus is LogoutSuccess){
                Navigator.of(context).pushNamed('/');
              }
            },
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Welcome', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
                  const Divider(height: 50, color: Colors.white),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Email: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                      Text('${_myUser.email}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Password: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                      Text('${_myUser.password}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
                    ],
                  ),
                ],
              ),
            )
          );
        })
      ),
    );
  }




  Widget _logOutButton(){
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state){
      return TextButton(
        onPressed: (){
          context.read<LoginBloc>().add(Logout());
        },
        child: const Text('Logout', style: TextStyle(color: Colors.white)),
      );
    });
  }

}
