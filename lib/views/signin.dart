import 'package:flutter/material.dart';
import 'package:quiz_maker/helper/functions.dart';
import 'package:quiz_maker/services/auth.dart';
import 'package:quiz_maker/views/signin_tutor.dart';
import 'package:quiz_maker/views/signup_tutor.dart';
import 'package:quiz_maker/widgets/widgets.dart';

import 'home.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  String email, password;
  AuthService authService = new AuthService();

  bool _isLoading = false;
  bool _secureText = true;
  String _passwordError;
  TextEditingController _passwordController = TextEditingController();

  SignIn() async {
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
              context, MaterialPageRoute(builder: (context) => Home()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

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
                                  builder: (context) => SignIn_Tutor()));
                        },
                        child: blueButton(
                            context: context,
                            label: "Tutor Sign In",
                            buttonWidth:
                                MediaQuery.of(context).size.width / 2 - 36)),
                    SizedBox(height: 20),
                    TextFormField(
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Enter Email";
                        } else if (!val.contains("@")) {
                          return "Please enter a valid email address";
                        }
                        return null;
                        // return val.isEmpty ? "Enter Email" : null;
                      },
                      maxLength: 25,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_box),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9)),
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
                      obscureText: _secureText,
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Enter Password";
                        } else if (_passwordController.text.length < 6) {
                          return "Enter at least 6 Characters";
                        } else {
                          return null;
                        }
                        // return val.isEmpty ? "Enter Password" : null;
                      },
                      controller: _passwordController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        errorText: _passwordError,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _secureText ? Icons.remove_red_eye : Icons.security,
                          ),
                          onPressed: () {
                            setState(() {
                              _secureText = !_secureText;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: "Password",
                        labelText: "Password",
                      ),
                      onChanged: (val) {
                        password = val;
                      },
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    InkWell(
                      onTap: () {
                        SignIn();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width / 2 - 36,
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                        child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUp_tutor()));
                      },
                      child: Text(
                        "Create Account",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
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
