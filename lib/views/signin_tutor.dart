import 'package:flutter/material.dart';
import 'package:quiz_maker/helper/functions.dart';
import 'package:quiz_maker/services/auth.dart';
import 'package:quiz_maker/views/signin.dart';
import 'package:quiz_maker/views/signup.dart';
import 'package:quiz_maker/widgets/widgets.dart';

import 'home_tutor.dart';

class SignIn_Tutor extends StatefulWidget {
  @override
  _SignIn_TutorState createState() => _SignIn_TutorState();
}

class _SignIn_TutorState extends State<SignIn_Tutor> {
  final _formKey = GlobalKey<FormState>();
  String email, password;
  AuthService authService = new AuthService();

  bool _isLoading = false;

  SignIn_tutor() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService.signInEmailandPass(email, password).then((val) {
        if (val != null) {
          setState(() {
            _isLoading = false;
          });
          HelperFunctions.saveUserLoginDetails(isLoggedIn: true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home_Tutor()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: _isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formKey,
              child: Container(
                  child: Column(
                    children: [
                      Spacer(),
                      SizedBox(
                        width: 24,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignIn()));
                          },
                          child: blueButton(
                              context: context,
                              label: "Student Sign In",
                              buttonWidth:
                                  MediaQuery.of(context).size.width / 2 - 36)),
                      SizedBox(height: 18),
                      TextFormField(
                        maxLength: 25,
                        validator: (val) {
                          return val.isEmpty ? "Enter EmailId" : null;
                        },
                        decoration: InputDecoration(
                          hintText: "Email",
                          labelText: "Email",
                        ),
                        onChanged: (val) {
                          email = val;
                        },
                      ),
                      SizedBox(height: 6),
                      TextFormField(
                        maxLength: 20,
                        obscureText: true,
                        validator: (val) {
                          return val.isEmpty ? "Enter Password" : null;
                        },
                        decoration: InputDecoration(
                          hintText: "Password",
                          labelText: "Password",
                        ),
                        onChanged: (val) {
                          password = val;
                        },
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      GestureDetector(
                          onTap: () {
                            SignIn_tutor();
                          },
                          child: blueButton(
                              context: context,
                              label: "Send",
                              buttonWidth:
                                  MediaQuery.of(context).size.width / 2 - 36)),
                      Container(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUp()));
                                },
                                child: Text(
                                  "Create Account",
                                  style: TextStyle(
                                    color: Colors.blue,
                                      fontSize: 17, fontWeight: FontWeight.bold,),
                                ),
                              )),
                      SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
              ),
            ),
    );
  }
}
