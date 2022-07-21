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
    try {
      firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((loginData) {});

      return {"success": true};
    } catch (e) {
      return {"success": false};
    }
  }

  Future<Map<String, bool>> ffLogout() async {
    try {
      firebaseAuth.signOut().then((registrant) {
        _userLoggedIn = false;
        _userName = "";
        notifyListeners();
      });
      return {"success": true};
    } catch (e) {
      return {"success": false};
    }
  }

  Future ffRegisterUser({
    required String name,
    required String email,
    required String password,
  }) {
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((regData) {
      User user = regData.user!;
      user.updateDisplayName(name);
      if (!user.emailVerified) {
        print("not verified");
      }

      _userName = name;
      notifyListeners();
    }).catchError((onError) {
      print(onError);
    });
  }
}
