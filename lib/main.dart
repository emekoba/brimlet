import 'package:brimlet/app_data.dart';
import 'package:brimlet/pages/auth.page.dart';
import 'package:brimlet/services/authentication_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OutPass',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: AuthenticationWrapper(
        builder: (authState) {
          return const AuthPage();
          // return const HomeView();
        },
      ),
    );
  }
}

// class Core extends StatefulWidget {
//   const Core({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _CoreState createState() => _CoreState();
// }

// class _CoreState extends State<Core> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: 
//     );
//   }
// }
