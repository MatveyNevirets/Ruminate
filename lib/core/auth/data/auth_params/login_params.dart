import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class FirebaseAuthCase {
  final googleSingIn = GoogleSignIn.instance;
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;

  Future<User?> login();
  Future<void> logout();
}

class FirebaseEmailCase extends FirebaseAuthCase {
  final String email, password;

  FirebaseEmailCase({required this.email, required this.password});

  @override
  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
    } on Object catch (e, stack) {
      throw Exception("$e StackTrace: $stack");
    }
  }

  @override
  Future<User?> login() async {
    final userCredential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    log("With email");
    final currentUser = userCredential.user;

    if (currentUser != null && !currentUser.emailVerified) {
      throw Exception("User not verified email");
    }

    return currentUser;
  }
}

class FirebaseFetchUserCase extends FirebaseAuthCase {
  @override
  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
    } on Object catch (e, stack) {
      throw Exception("$e StackTrace: $stack");
    }
  }

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
  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
    } on Object catch (e, stack) {
      throw Exception("$e StackTrace: $stack");
    }
  }

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
