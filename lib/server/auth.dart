import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tiba/models/db_model.dart';
import 'package:toast/toast.dart';
import 'database_api.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  UserModel _userFromFirebaseUser(User user) {return user != null ? UserModel(id: user.uid) : null;}

  // auth change user stream
  Stream<User> get user {
    return _auth.authStateChanges();
  }

  // sign in with email and password
  Future signInWithEmailAndPassword({BuildContext context, String email, String password}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Toast.show("لم يتم العثور على مستخدم", context,
            backgroundColor: Colors.redAccent,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM);
      } else if (e.code == 'wrong-password') {
        Toast.show("كلمة مرور خاطئة", context,
            backgroundColor: Colors.redAccent,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM);
      }
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword({BuildContext context,UserModel newUser,File userImage}) async {
    try {
      print('XDA : ' + newUser.type);
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: '${newUser.userId}.${newUser.type}@tiba.com', password: newUser.password);
      print('XDA : ' + result.user.uid);

      User fbUser = result.user;
      newUser.id = fbUser.uid;
      await DatabaseService().updateUserData(user: newUser);

      return _userFromFirebaseUser(fbUser);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Toast.show("كلمة المرور المقدمة ضعيفة للغاية.", context,
            backgroundColor: Colors.redAccent,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM);
      } else if (e.code == 'email-already-in-use') {
        Toast.show("الحساب موجود بالفعل", context,
            backgroundColor: Colors.redAccent,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM);
      }
    } catch (e) {
      print(e);
    }
  }


  Future registerWithoutLogin({BuildContext context, UserModel newUser}) async {
    FirebaseApp app = await Firebase.initializeApp(
        name: 'Secondary', options: Firebase.app().options);
    try {
      UserCredential userCredential = await FirebaseAuth.instanceFor(app: app)
          .createUserWithEmailAndPassword(
          email: '${newUser.userId}.${newUser.type}@tiba.com', password: newUser.password);
      User fbUser = userCredential.user;
      newUser.id = fbUser.uid;
      await DatabaseService().updateUserData(user: newUser);
      await app.delete();
      Navigator.pop(context);

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Toast.show("كلمة المرور المقدمة ضعيفة للغاية.", context,
            backgroundColor: Colors.redAccent,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM);
      } else if (e.code == 'email-already-in-use') {
        Toast.show("الحساب موجود بالفعل", context,
            backgroundColor: Colors.redAccent,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM);
      }
    } catch (e) {
      print(e);
    }
  }

  void changePassword(String password,Function() fun) async{
    if (password==null) {
      fun();
    }  else {
      //Create an instance of the current user.
      final user = _auth.currentUser;
      //Pass in the password to updatePassword.
      user.updatePassword(password).then((_){
        print("Successfully changed password");
        fun();
      }).catchError((error){
        print("Password can't be changed" + error.toString());
        //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
      });
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
