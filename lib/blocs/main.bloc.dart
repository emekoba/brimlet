import 'dart:developer';

import 'package:brimlet/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class MainBloc extends ChangeNotifier {
  bool _userLoggedIn = false;
  bool _userVerified = true;
  String _userName = "Russell";
  final String _verificationCode = "423f2";

  String get userName => _userName;
  String get verificationCode => _verificationCode;
  bool get userLoggedIn => _userLoggedIn;
  bool get userVerified => _userVerified;

  Future ffLogin({
    required String email,
    required String password,
  }) {
    return firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((loginData) {
      _userName = loginData.user!.displayName!;
      _userLoggedIn = true;
    });
  }

  Future ffLogout() async {
    firebaseAuth.signOut().then((res) {
      _userLoggedIn = false;
      _userVerified = false;
      _userName = "";
      notifyListeners();
    });
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

  bool verifyUser({required String code}) {
    if (code == _verificationCode) {
      _userVerified = true;
    } else {
      _userVerified = false;
    }

    return _userVerified;
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
        log("not verified");
      }
    }).catchError((onError) {
      log(onError);
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
      );
    }

    return isAuthenticated;
  }
}
