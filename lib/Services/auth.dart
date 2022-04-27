import 'package:firebase_auth/firebase_auth.dart';
import 'package:split/Models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:split/Services/database.dart';

//changed to return null fixed the loading screen

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //create user obj based on firebase user

  MyUser? _userfromFirebase(User? user) {//makin a user
    return user != null ? MyUser(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<MyUser?> get user{
    return _auth.authStateChanges()
        .map((User? user) => _userfromFirebase(user));
  }

  //sign in anon
  Future signInAnon() async{
    try{
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userfromFirebase(user!);
    }catch(e){
      print(e.toString());
      return null;
      //return e;
    }
  }

  //sign in with email and pass
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
      User? user = result.user;

      //wrong place maybe?
      //create a user with the uid
      //await DataBaseService(uid: user!.uid).updateUserData('name');
      return _userfromFirebase(user);
    }on FirebaseAuthException catch(e){
      print(e.toString());
      return null;
      //return e.message;
    }
  }

  //register with email and pass
  Future registerWithEmailAndPassword(String email, String password, String name, bool notification) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim());
      User? user = result.user;
      //create a new document for user with UID
      await DataBaseService(uid: user!.uid).updateUserData(email, name, notification);
      return _userfromFirebase(user);
    }on FirebaseAuthException catch(e){
      print(e.toString());
      return null;
      //return e.message;
    }
  }

  //sign out
  Future signOut() async{
      try{
        return await _auth.signOut();
      }
      catch(e){
        print(e.toString());
        return e;
      }
  }
}