import 'package:flutter/material.dart';
import 'package:quiz_maker/helper/functions.dart';
import 'package:quiz_maker/services/auth.dart';
import 'package:quiz_maker/views/signin.dart';
import 'package:quiz_maker/views/signin_tutor.dart';
import 'package:quiz_maker/views/signup.dart';
import 'package:quiz_maker/widgets/widgets.dart';

class SignUp_tutor extends StatefulWidget {
  @override
  _SignUp_tutorState createState() => _SignUp_tutorState();
}

class _SignUp_tutorState extends State<SignUp_tutor> {
  final _formKey = GlobalKey<FormState>();
  String staffno, email, password;
  AuthService authService = new AuthService();
  bool _isloading = false;

  SignUp_tutor() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isloading = true;
      });
      authService.signUpWithEmailAndPassword(email, password).then((value) {
        if (value != null) {
          setState(() {
            _isloading = false;
          });
          HelperFunctions.saveUserLoginDetails(isLoggedIn: true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => SignIn_Tutor()));
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
      body: _isloading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
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
                                  builder: (context) => SignUp()));
                        },
                        child: blueButton(
                            context: context,
                            label: "Student Sign Up",
                            buttonWidth:
                                MediaQuery.of(context).size.width / 2 - 36)),
                    SizedBox(height: 18),
                    SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      validator: (val) {
                        return val.isEmpty ? "Enter Staff Number" : null;
                      },
                      decoration: InputDecoration(
                        hintText: "Staff Number",
                      ),
                      onChanged: (val) {
                        staffno = val;
                      },
                    ),
                    TextFormField(
                      validator: (val) {
                        return val.isEmpty ? "Enter EmailId" : null;
                      },
                      decoration: InputDecoration(
                        hintText: "Email",
                      ),
                      onChanged: (val) {
                        email = val;
                      },
                    ),
                    SizedBox(height: 6),
                    TextFormField(
                      obscureText: true,
                      validator: (val) {
                        return val.isEmpty ? "Enter Password" : null;
                      },
                      decoration: InputDecoration(
                        hintText: "Password",
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
                          SignUp_tutor();
                        },
                        child: blueButton(
                            context: context,
                            label: "Send",
                            buttonWidth:
                                MediaQuery.of(context).size.width / 2 - 36)),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: TextStyle(fontSize: 15.5),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignIn()));
                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                  fontSize: 15.5,
                                  decoration: TextDecoration.underline),
                            ))
                      ],
                    ),
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
