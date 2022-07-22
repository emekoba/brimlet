import 'package:brimlet/app_data.dart';
import 'package:brimlet/blocs/main.bloc.dart';
import 'package:brimlet/constants.dart';
import 'package:brimlet/pages/home_view.page.dart';
import 'package:brimlet/pages/login.page.dart';
import 'package:brimlet/pages/registration.page.dart';
import 'package:brimlet/pages/verification.page.dart';
import 'package:brimlet/utils/authentication_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MainBloc>.value(value: MainBloc()),
      ],
      child: MaterialApp(
        title: 'OutPass',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        home: AuthenticationWrapper(
          builder: (authState) {
            switch (authState) {
              case FbAuthStates.registeredUnverified:
                return const VerificationPage();

              case FbAuthStates.registeredVerified:
                return const LoginPage();

              case FbAuthStates.signedOut:
                return const RegistrationPage();

              case FbAuthStates.signedIn:
                return const HomeView();

              default:
                return const RegistrationPage();
            }
            // return const HomeView();
          },
        ),
      ),
    );
  }
}
