import 'package:flutter/material.dart';
import 'package:quiz_maker/helper/functions.dart';
import 'package:quiz_maker/services/auth.dart';
import 'package:quiz_maker/views/signin.dart';
import 'package:quiz_maker/views/signup_tutor.dart';
import 'package:quiz_maker/widgets/widgets.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String regNo, email, password;
  AuthService authService = new AuthService();
  bool _isloading = false;
  bool _secureText = true;  
  String _passwordError;
  TextEditingController _passwordController = TextEditingController();

  signUp() async {
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
              context, MaterialPageRoute(builder: (context) => SignIn()));
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
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    // SizedBox(height: 10),
                    Image.asset(
                      'lib/images/quizzlogo.jpg',
                      width: 250,
                      height: 150,
                    ),
                    Text("Register As a Student",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 18,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500)),
                    SizedBox(height: 23),
                    TextFormField(
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Enter RegNo";
                        } else if (!val.contains("/")) {
                          return "Please enter a valid reg number";
                        } 
                        return null;
                      },
                      maxLength: 25,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.format_list_numbered),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9)),
                        hintText: "RegNo",
                        labelText: "RegNo",
                      ),
                      onChanged: (val) {
                        email = val;
                      },
                    ),
                    SizedBox(height: 5),
                    TextFormField(
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Enter Email";
                        } else if (!val.contains("@")) {
                          return "Please enter a valid email address";
                        }
                        return null;
                      },
                      maxLength: 25,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.mail),
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
                        signUp();
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
                          "Register",
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
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignIn()));
                            },
                            child: Text(
                              "Log In",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),
                          SizedBox(
                            width: 5,
                          ),
                          VerticalDivider(
                            color: Colors.black,
                            thickness: 3,
                            width: 20,
                          ),
                          SizedBox(
                            width: 5,
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
                              "Tutor SignUp",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 45,
                    ),
                  ],
                ),
              )),
    );
  }
}
