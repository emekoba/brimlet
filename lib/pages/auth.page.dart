import 'package:brimlet/blocs/main.bloc.dart';
import 'package:brimlet/pages/verification.page.dart';
import 'package:brimlet/services/firebase.service.dart';
import 'package:brimlet/widgets/dismiss_keyboard.dart';
import 'package:brimlet/widgets/op_button.dart';
import 'package:brimlet/widgets/op_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLoginForm = false;

  Map<String, String> form = {
    "name": "Russell",
    "email": "rjemekoba@gmail.com",
    "password": "Password1\$",
  };

  @override
  Widget build(BuildContext context) {
    MainBloc mainBloc = Provider.of<MainBloc>(context);

    void _updateForm(String value, String field) {
      setState(() {
        form[field] = value;
      });
    }

    void _goToVerification() {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => const VerificationPage(),
        ),
      );
    }

    void _popSnack({required String text, Color? hue}) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            text,
            style: TextStyle(color: hue ?? Colors.redAccent),
          ),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.white,
        ),
      );
    }

    void _login() {
      Future loginFuture = mainBloc.ffLogin(
        email: form["email"] as String,
        password: form["password"] as String,
      );
    }

    void _register() {
      // firebaseUser!.delete();
      if (firebaseUser == null) {
        Future regFuture = mainBloc.ffRegisterUser(
          name: form["name"] as String,
          email: form["email"] as String,
          password: form["password"] as String,
        );

        regFuture.then((value) {
          _popSnack(text: "Sign Up Successful", hue: Colors.green);
          _goToVerification();
        }).onError((error, stackTrace) {
          _popSnack(text: "Sign Up Failed");
        });
      } else {
        _popSnack(text: "User Already Exists");
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
                    isLoginForm
                        ? Container()
                        : OpTextfield(
                            useIcon: true,
                            type: OpTextFieldTypes.name,
                            onChange: (val) => _updateForm(val, "name"),
                          ),
                    const SizedBox(height: 40),
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
            SizedBox(
              height: 55,
              child: OpButton(
                label: isLoginForm ? "Sign In" : "Sign Up",
                onPressed: isLoginForm ? _login : _register,
              ),
            )
          ],
        ),
      ),
    );
  }
}
