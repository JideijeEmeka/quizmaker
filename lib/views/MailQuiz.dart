import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:quiz_maker/widgets/widgets.dart';

class MailQuiz extends StatefulWidget {
  @override
  _MailQuizState createState() => _MailQuizState();
}

class _MailQuizState extends State<MailQuiz> {
  final _formkey = GlobalKey<FormState>();
  bool _isLoading = false;
  String val, email;

  mailQuiz() {
    if (_formkey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
    } else if (val != null) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: _isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formkey,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    SizedBox(height: 60),
                    GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                      },
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.format_list_numbered),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                          labelText: "Your RegNo",
                          // enabled: false,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.grade),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        labelText: "Score",
                      ),
                      enabled: false,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Enter Lecturer`s email";
                        } else if (!val.contains("@")) {
                          return "Enter a valid email";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        labelText: "Lecturer`s mail",
                        enabled: true,
                      ),
                      onChanged: (val) {
                        email = val;
                      },
                    ),
                    SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        mailQuiz();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width / 2 - 36,
                        child: Text(
                          "Send",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}