import 'dart:developer';

import 'package:brimlet/services/firebase.service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainBloc extends ChangeNotifier {
  bool _userLoggedIn = false;

  bool get userLoggedIn => _userLoggedIn;

  Future<Map<String, bool>> ffLogin({
    required String via,
    required String email,
    required String password,
  }) async {
    switch (via) {
      case "email":
        firebaseAuth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((registrant) {})
            .catchError((dynamic e) {
          log(e);
        });
        break;

      case "google":
        break;

      case "facebook":
        break;

      default:
    }

    return {
      "success": true,
    };
  }

  Future<void> ffLogout() async {
    firebaseAuth.signOut().then((registrant) {
      _userLoggedIn = false;
    });
  }

  Future<void> ffRegisterUser({
    required String via,
    required String email,
    required String password,
  }) async {
    switch (via) {
      case "email":
        FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((registrant) {})
            .catchError((dynamic e) {
          log(e);
        });

        break;

      default:
    }
  }
}
