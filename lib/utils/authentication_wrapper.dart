import 'package:brimlet/blocs/main.bloc.dart';
import 'package:brimlet/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  FbAuthStates authState = FbAuthStates.registeredVerified;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      MainBloc mainBloc = Provider.of<MainBloc>(context, listen: false);

      if (firebaseUser == null) {
        setState(() => authState = FbAuthStates.signedOut);
      } else {
        await firebaseUser!.reload();

        if (mainBloc.userVerified) {
          setState(() => authState = FbAuthStates.registeredVerified);
        } else {
          setState(() => authState = FbAuthStates.registeredUnverified);
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(authState);
  }
}
