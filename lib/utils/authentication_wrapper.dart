import 'package:brimlet/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationWrapper extends StatefulWidget {
  final Function builder;

  const AuthenticationWrapper({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  State<AuthenticationWrapper> createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  FbAuthStates authState = FbAuthStates.signedOut;

  @override
  void initState() {
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        setState(() {
          authState = FbAuthStates.signedOut;
        });
      } else {
        setState(() {
          authState = FbAuthStates.signedIn;
        });
      }
    });

    // FirebaseAuth.instance.userChanges().listen((User? user) {
    //   if (user == null) {
    //     setState(() {
    //       authState = FbAuthStates.signedOut;
    //     });
    //   } else {
    //     setState(() {
    //       authState = FbAuthStates.signedIn;
    //     });
    //   }
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(authState);
  }
}
