import 'dart:developer';

import 'package:brimlet/services/firebase.service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainBloc extends ChangeNotifier {
  bool _userLoggedIn = false;
  String _userName = "";

  bool get userLoggedIn => _userLoggedIn;
  String get userName => _userName;

  Future<Map<String, bool>> ffLogin({
    required String email,
    required String password,
  }) async {
    firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((registrant) {})
        .catchError((dynamic e) {
      log(e);
    });

    return {
      "success": true,
    };
  }

  Future<Map<String, bool>> ffLogout() async {
    try {
      firebaseAuth.signOut().then((registrant) {
        _userLoggedIn = false;
        _userName = "";
        notifyListeners();
      });
      return {"success": false};
    } catch (e) {
      return {"success": false};
    }
  }

  Future<Map<String, bool>> ffRegisterUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((regData) {
        regData.user!.updateDisplayName(name);
        _userName = name;
        notifyListeners();
      }).catchError((dynamic e) {
        log(e);
      });
      return {"success": false};
    } catch (e) {
      return {"success": false};
    }
  }
}
