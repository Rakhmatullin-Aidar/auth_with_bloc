import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth _fAuth = FirebaseAuth.instance;


  Future<User?> signIn(String email, String password) async{
    try{
      UserCredential result = await _fAuth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      return result.user;
    }catch(e){
      return null;
    }
  }


  Future<User?> register(String email, String password) async {
     try{
       UserCredential result = await _fAuth.createUserWithEmailAndPassword(
         email: email,
         password: password
       );
       User? user = result.user;
       return user;
     }catch(e){
        return null;
     }
  }

  Future<void> signOut() async{
    await _fAuth.signOut();
  }


}