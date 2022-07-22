import 'package:brimlet/blocs/main.bloc.dart';
import 'package:brimlet/pages/login.page.dart';
import 'package:brimlet/widgets/dismiss_keyboard.dart';
import 'package:brimlet/widgets/op_button.dart';
import 'package:brimlet/widgets/op_snack.dart';
import 'package:brimlet/widgets/op_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({Key? key}) : super(key: key);

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  String _verificationCode = "";

  @override
  Widget build(BuildContext context) {
    MainBloc mainBloc = Provider.of<MainBloc>(context);

    void updateForm(String value) {
      setState(() => _verificationCode = value);
    }

    void _goToLogin() {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => const LoginPage(),
        ),
      );
    }

    void verify() {
      // firebaseUser!.delete();
      // if (firebaseUser == null) {
      //   Future regFuture = mainBloc.ffRegisterUser(
      //     name: form["name"] as String,
      //     email: form["email"] as String,
      //     password: form["password"] as String,
      //   );

      //   regFuture.then((value) {
      //     popSnack(text: "Sign Up Successful");
      //   }).onError((error, stackTrace) {
      //     popSnack(text: "Sign Up Failed");
      //   });
      // } else {
      //   popSnack(text: "User Already Exists");
      // }

      popSnack(
        context: context,
        text: "Verification Successful",
        hue: Colors.green,
      );

      _goToLogin();
    }

    return Scaffold(
      body: DismissKeyboard(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OpTextfield(
                      useIcon: true,
                      type: OpTextFieldTypes.code,
                      onChange: (val) => updateForm(val),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 55,
              child: OpButton(
                label: "verify",
                onPressed: verify,
              ),
            )
          ],
        ),
      ),
    );
  }
}
