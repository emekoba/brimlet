import 'dart:convert';
import 'dart:developer';

import 'package:brimlet/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainBloc extends ChangeNotifier {
  bool _userLoggedIn = false;
  bool _userVerified = true;
  dynamic _user = {};
  final String _verificationCode = "423f2";

  Map get user => _user;
  String get verificationCode => _verificationCode;
  bool get userLoggedIn => _userLoggedIn;
  bool get userVerified => _userVerified;

  Future ffLogin({
    required String email,
    required String password,
  }) {
    return firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((loginData) async {
      _user = {
        "displayName": loginData.user!.displayName,
        "email": loginData.user!.email,
        "uid": loginData.user!.uid,
      };

      _userLoggedIn = true;

      final SharedPreferences store = await SharedPreferences.getInstance();
      await store.setString("user", json.encode(_user));

      notifyListeners();
    });
  }

  Future ffLogout() async {
    firebaseAuth.signOut().then((res) {
      _userLoggedIn = false;
      _userVerified = false;
      _user = {};
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

  Future<Map<String, dynamic>> authenticateWithBiometrics() async {
    bool isAuthenticated = false;
    final SharedPreferences store = await SharedPreferences.getInstance();
    String? userString = store.getString("user");
    Map user = {};

    if (userString != null) {
      user = json.decode(userString);
    }

    if (user.isNotEmpty) {
      final LocalAuthentication localAuthentication = LocalAuthentication();
      bool isBiometricSupported = await localAuthentication.isDeviceSupported();
      bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;

      if (isBiometricSupported && canCheckBiometrics) {
        isAuthenticated = await localAuthentication.authenticate(
          localizedReason: 'Please complete the biometrics to proceed.',
        );
      }

      if (isAuthenticated) {
        _user = user;
        notifyListeners();
        return {
          "isAuthenticated": isAuthenticated,
          "message": "biometrics failed",
        };
      } else {
        return {
          "isAuthenticated": isAuthenticated,
          "message": "biometrics successful",
        };
      }
    } else {
      return {
        "isAuthenticated": isAuthenticated,
        "message": "You Must Login at Least Once to Use Biometrics",
      };
    }
  }
}
