import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quiz_maker/views/home.dart';
import 'package:quiz_maker/views/signin.dart';
import 'package:quiz_maker/views/signin_tutor.dart';

import 'helper/functions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool _isLoggedIn = false;
  checkUserLoggedInStatus() async {
    HelperFunctions.getUserLoginDetails().then((value) {
      setState(() {
        _isLoggedIn = value;
      });
    });
  }

  @override
  void initState() {
    checkUserLoggedInStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz Maker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: (_isLoggedIn ?? false) ? Home() : SignIn_Tutor(),
    );
  }
}
