import 'dart:developer';

import 'package:brimlet/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class MainBloc extends ChangeNotifier {
  bool _userLoggedIn = false;
  String _userName = "";

  bool get userLoggedIn => _userLoggedIn;
  String get userName => _userName;

  Future ffLogin({
    required String email,
    required String password,
  }) {
    return firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((loginData) {
      print(loginData);
    });
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

  Future<void> ffVerifyUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
    } catch (e) {
      log(e.toString());
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

  Future<bool> authenticateWithBiometrics() async {
    final LocalAuthentication localAuthentication = LocalAuthentication();
    bool isBiometricSupported = await localAuthentication.isDeviceSupported();
    bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;

    bool isAuthenticated = false;

    if (isBiometricSupported && canCheckBiometrics) {
      isAuthenticated = await localAuthentication.authenticate(
        localizedReason: 'Please complete the biometrics to proceed.',
        // biometricOnly: true,
      );
    }

    return isAuthenticated;
  }
}
