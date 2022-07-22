import 'dart:developer';

import 'package:brimlet/blocs/main.bloc.dart';
import 'package:brimlet/pages/home_view.page.dart';
import 'package:brimlet/pages/registration.page.dart';
import 'package:brimlet/widgets/op_button.dart';
import 'package:brimlet/widgets/op_snack.dart';
import 'package:brimlet/widgets/op_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Map<String, String> form = {
    "email": "",
    "password": "",
  };

  @override
  Widget build(BuildContext context) {
    MainBloc mainBloc = Provider.of<MainBloc>(context);

    void _goToHome() {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => const HomeView(),
        ),
      );
    }

    void _goToReg() {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => const RegistrationPage(),
        ),
      );
    }

    void _updateForm(String value, String field) {
      setState(() => form[field] = value);
    }

    void _loginViaEmail() {
      if (form.values.where((element) => element.isEmpty).isEmpty) {
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
          _goToHome();
        }).onError((error, stackTrace) {
          log(error.toString());
          popSnack(context: context, text: "Sign In Failed");
        });
      } else {
        popSnack(context: context, text: "One or More Fields are Empty");
      }
    }

    void _loginViaBiometrics() async {
      bool isAuthenticated = await mainBloc.authenticateWithBiometrics();

      if (isAuthenticated) {
        popSnack(
          context: context,
          text: "Sign In Successful",
          hue: Colors.green,
        );
        _goToHome();
      } else {
        popSnack(context: context, text: "Sign In Failed");
      }
    }

    return Scaffold(
      body: Column(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: _goToReg,
                        child: Row(
                          children: const [
                            Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          TextButton(
            onPressed: _loginViaBiometrics,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
              shape: MaterialStateProperty.all(const CircleBorder()),
            ),
            child: const Icon(
              Icons.fingerprint,
              size: 50,
              color: Colors.redAccent,
            ),
          ),
          const SizedBox(height: 40),
          SizedBox(
            height: 55,
            child: OpButton(
              label: "Sign In",
              onPressed: _loginViaEmail,
            ),
          )
        ],
      ),
    );
  }
}
