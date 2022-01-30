import 'package:authorization_with_bloc/auth/auth_service.dart';
import 'package:authorization_with_bloc/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pages/login_view.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => RepositoryProvider(
          create: (context) => AuthService(),
          child: LoginView(),
        ),
        '/homepage': (context) => RepositoryProvider(
          create: (context) => AuthService(),
          child: const HomePage(),
        ),
      },

    );
  }
}





