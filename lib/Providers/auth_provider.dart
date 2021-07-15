import 'package:firebase_auth/firebase_auth.dart';

class AuthClass {
  FirebaseAuth auth = FirebaseAuth.instance;

  //Create Account
  Future<String> createAccount(
      {required String email, required String password}) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Account Created';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'Weak Password';
      } else if (e.code == 'email-already-in-use') {
        return 'Account Already Exists';
      }
    } catch (e) {
      return 'Account Creation Failed';
    }
    return "An Error Occured";
  }

  //Login
  Future<String> signIn(
      {required String email, required String password}) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Welcome';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No User Found';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    }
    return 'An Error Occured';
  }

  //Reset Password
  Future<String> resetPassword({required String email}) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return 'Email Reset Successfully';
    } catch (e) {
      return 'An Error Occured';
    }
  }

  //Sign Out
  void signOut() {
    auth.signOut();
  }
}
