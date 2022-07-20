import 'package:brimlet/widgets/op_textfield.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OpTextfield(
              type: OpTextFieldTypes.email,
              onChange: () {},
            )
          ],
        ),
      ),
    );
  }
}
