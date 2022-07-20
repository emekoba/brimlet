import 'package:brimlet/widgets/dismiss_keyboard.dart';
import 'package:brimlet/widgets/op_button.dart';
import 'package:brimlet/widgets/op_textfield.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLoginForm = true;
  String name = "";
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
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
                            onChange: () {},
                          ),
                    const SizedBox(height: 40),
                    OpTextfield(
                      useIcon: true,
                      type: OpTextFieldTypes.email,
                      onChange: () {},
                    ),
                    const SizedBox(height: 40),
                    OpTextfield(
                      useIcon: true,
                      type: OpTextFieldTypes.password,
                      onChange: () {},
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
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
