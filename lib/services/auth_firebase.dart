import 'package:chat_app/component/reused_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthFirebaseMethods {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future signUp(context, email, password) async {
    try {
      UserCredential result = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future signInWithEmailAndPassword(context, email, password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        reusedDialog(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        reusedDialog(context, 'Wrong password provided for that user.');
      }
    }
  }

  Future signOut() async {
    try {
      return await firebaseAuth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
