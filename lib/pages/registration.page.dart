import 'package:brimlet/blocs/main.bloc.dart';
import 'package:brimlet/constants.dart';
import 'package:brimlet/pages/verification.page.dart';
import 'package:brimlet/widgets/dismiss_keyboard.dart';
import 'package:brimlet/widgets/op_button.dart';
import 'package:brimlet/widgets/op_snack.dart';
import 'package:brimlet/widgets/op_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  Map<String, String> form = {
    "name": "Russell",
    "email": "rjemekoba@gmail.com",
    "password": "Password1\$",
  };

  @override
  Widget build(BuildContext context) {
    MainBloc mainBloc = Provider.of<MainBloc>(context);

    void _updateForm(String value, String field) {
      setState(() => form[field] = value);
    }

    void _goToVerification() {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => const VerificationPage(),
        ),
      );
    }

    void _register() async {
      // await firebaseUser!.delete();
      // print(firebaseUser);

      // await firebaseUser!.reload();
      if (firebaseUser == null) {
        Future regFuture = mainBloc.ffRegisterUser(
          name: form["name"] as String,
          email: form["email"] as String,
          password: form["password"] as String,
        );

        regFuture.then((value) {
          popSnack(
            context: context,
            text: "Sign Up Successful",
            hue: Colors.green,
          );
          _goToVerification();
        }).onError((error, stackTrace) {
          popSnack(context: context, text: "Sign Up Failed");
        });
      } else {
        popSnack(context: context, text: "User Already Exists");
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
                label: "Sign Up",
                onPressed: _register,
              ),
            )
          ],
        ),
      ),
    );
  }
}
