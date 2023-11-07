import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_database/firebase_database.dart';

bool guestLogin = false;

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  User? get user => _auth.currentUser;

  //SIGN UP METHOD
  Future signUp({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<bool> deleteUser() async {
    try {
      user?.delete();
      final uid = user?.uid;
      DatabaseReference ref = FirebaseDatabase.instance.ref("users/$uid");
      ref.remove();
      return true;
    } catch (e) {
      return false;
    }
  }

  //SIGN IN METHOD
  Future signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN OUT METHOD
  Future signOut() async {
    await _auth.signOut();

    print('signout');
  }

  Future<String?> signInwithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      rethrow;
    }
    return null;
  }

  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}

class AuthenticationStateChangeNotifier extends ValueNotifier<bool> {
  AuthenticationStateChangeNotifier() : super(false) {
    _notifyUser(FirebaseAuth.instance.currentUser);
    FirebaseAuth.instance.authStateChanges().listen(_notifyUser);
  }

  void _notifyUser(User? user) {
    if (user == null) {
      signOut();
    } else {
      signIn();
    }
  }

  void signIn() {
    value = true;
    notifyListeners();
  }

  void signOut() {
    value = false;
    notifyListeners();
  }
}
