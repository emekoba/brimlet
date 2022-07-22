import 'package:firebase_auth/firebase_auth.dart';

enum FbAuthStates {
  signedOut,
  signedIn,
  registeredUnverified,
  registeredVerified,
}

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
User? firebaseUser = FirebaseAuth.instance.currentUser;
