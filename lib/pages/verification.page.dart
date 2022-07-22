import 'package:brimlet/blocs/main.bloc.dart';
import 'package:brimlet/pages/login.page.dart';
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
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      MainBloc mainBloc = Provider.of<MainBloc>(context, listen: false);

      setState(() {
        _verificationCode = mainBloc.verificationCode;
      });
    });

    super.initState();
  }

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

    void _verify() {
      bool verified = mainBloc.verifyUser(
        code: _verificationCode,
      );

      if (verified) {
        popSnack(
          context: context,
          text: "Verification Successful",
          hue: Colors.green,
        );
        _goToLogin();
      } else {
        popSnack(context: context, text: "Verification Failed");
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
                    type: OpTextFieldTypes.code,
                    onChange: (val) => updateForm(val),
                    hintText: _verificationCode,
                    centerText: true,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 55,
            child: OpButton(
              label: "verify",
              onPressed: _verify,
            ),
          )
        ],
      ),
    );
  }
}
