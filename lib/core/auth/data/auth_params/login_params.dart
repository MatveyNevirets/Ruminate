import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class FirebaseAuthCase {
  final googleSingIn = GoogleSignIn.instance;
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;

  Future<User?> login();
}

class FirebaseEmailCase extends FirebaseAuthCase {
  final String email, password;

  FirebaseEmailCase({required this.email, required this.password});

  @override
  Future<User?> login() {
    // TODO: implement login
    throw UnimplementedError();
  }
}

class FirebaseFetchUserCase extends FirebaseAuthCase {
  @override
  Future<User?> login() async {
    try {
      final user = firebaseAuth.currentUser;
      return user;
    } on Object catch (e, stack) {
      throw Exception("$e StackTrace: $stack");
    }
  }
}

class FirebaseGoogleCase extends FirebaseAuthCase {
  FirebaseGoogleCase();

  @override
  Future<User?> login() async {
    GoogleSignInAccount? googleAccount = await googleSingIn.authenticate();

    final auth = googleAccount.authentication;

    final googleCredential = GoogleAuthProvider.credential(
      idToken: auth.idToken,
    );

    final userFirebase = await firebaseAuth.signInWithCredential(
      googleCredential,
    );

    await firebaseFirestore
        .collection("users")
        .doc(userFirebase.user?.uid)
        .set({});

    return userFirebase.user;
  }
}
