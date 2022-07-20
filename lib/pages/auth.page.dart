import 'package:brimlet/blocs/main.bloc.dart';
import 'package:brimlet/widgets/dismiss_keyboard.dart';
import 'package:brimlet/widgets/op_button.dart';
import 'package:brimlet/widgets/op_textfield.dart';
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
    "name": "",
    "email": "",
    "password": "",
  };

  @override
  Widget build(BuildContext context) {
    MainBloc mainBloc = Provider.of<MainBloc>(context);

    updateForm(String value, String field) {
      setState(() {
        form[field] = value;
      });
    }

    submit() {
      if (isLoginForm) {
        mainBloc.ffLogin(
          email: form["email"] as String,
          password: form["password"] as String,
        );
      } else {
        mainBloc.ffRegisterUser(
          name: form["name"] as String,
          email: form["email"] as String,
          password: form["password"] as String,
        );
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
                            onChange: (val) => updateForm(val, "name"),
                          ),
                    const SizedBox(height: 40),
                    OpTextfield(
                      useIcon: true,
                      type: OpTextFieldTypes.email,
                      onChange: (val) => updateForm(val, "email"),
                    ),
                    const SizedBox(height: 40),
                    OpTextfield(
                      useIcon: true,
                      type: OpTextFieldTypes.password,
                      onChange: (val) => updateForm(val, "password"),
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
                onPressed: submit,
              ),
            )
          ],
        ),
      ),
    );
  }
}
