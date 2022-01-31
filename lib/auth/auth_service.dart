import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth _fAuth = FirebaseAuth.instance;


  Future<User?> signIn(String email, String password) async{
    UserCredential result = await _fAuth.signInWithEmailAndPassword(
        email: email,
        password: password
    );
    return result.user;
  }


  Future<User?> register(String email, String password) async {
     UserCredential result = await _fAuth.createUserWithEmailAndPassword(
       email: email,
       password: password
     );
     return result.user;
  }

  Future<void> signOut() async{
    await _fAuth.signOut();
  }


}