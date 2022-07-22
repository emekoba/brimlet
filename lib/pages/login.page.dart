import 'dart:developer';

import 'package:brimlet/blocs/main.bloc.dart';
import 'package:brimlet/widgets/dismiss_keyboard.dart';
import 'package:brimlet/widgets/op_button.dart';
import 'package:brimlet/widgets/op_snack.dart';
import 'package:brimlet/widgets/op_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Map<String, String> form = {
    "email": "rjemekoba@gmail.com",
    "password": "Password1\$",
  };

  @override
  Widget build(BuildContext context) {
    MainBloc mainBloc = Provider.of<MainBloc>(context);

    void _updateForm(String value, String field) {
      setState(() => form[field] = value);
    }

    void _loginViaEmail() {
      Future loginFuture = mainBloc.ffLogin(
        email: form["email"] as String,
        password: form["password"] as String,
      );

      loginFuture.then((value) {
        popSnack(
          context: context,
          text: "Sign In Successful",
          hue: Colors.green,
        );
      }).onError((error, stackTrace) {
        log(error.toString());
        popSnack(context: context, text: "Sign In Failed");
      });
    }

    void _loginViaBiometrics() async {
      bool isAuthenticated = await mainBloc.authenticateWithBiometrics();

      if (isAuthenticated) {
        log("----------biometrics successful");
      } else {
        log("----------biometrics failed");
      }
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
                      type: OpTextFieldTypes.email,
                      onChange: (val) => _updateForm(val, "email"),
                    ),
                    const SizedBox(height: 40),
                    OpTextfield(
                      useIcon: true,
                      type: OpTextFieldTypes.password,
                      onChange: (val) => _updateForm(val, "password"),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 50),
              child: IconButton(
                onPressed: _loginViaBiometrics,
                icon: const Icon(
                  Icons.fingerprint,
                  size: 50,
                ),
              ),
            ),
            SizedBox(
              height: 55,
              child: OpButton(
                label: "Sign In",
                onPressed: _loginViaEmail,
              ),
            )
          ],
        ),
      ),
    );
  }
}
