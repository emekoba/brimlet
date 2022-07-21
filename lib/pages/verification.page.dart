import 'package:brimlet/blocs/main.bloc.dart';
import 'package:brimlet/widgets/dismiss_keyboard.dart';
import 'package:brimlet/widgets/op_button.dart';
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
      setState(() {
        _verificationCode = value;
      });
    }

    void popSnack({required String text}) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(text, style: const TextStyle(color: Colors.redAccent)),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.white,
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
                  children: const [
                    // OpTextfield(
                    //   useIcon: true,
                    //   type: OpTextFieldTypes.password,
                    //   // onChange: (val) => updateForm(val, "password"),
                    // ),
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
