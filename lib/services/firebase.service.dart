import 'package:firebase_auth/firebase_auth.dart';

enum FbAuthStates {
  signedOut,
  signedIn,
}

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
