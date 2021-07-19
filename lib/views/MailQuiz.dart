import 'package:flutter/material.dart';
import 'package:quiz_maker/user_model.dart';
import 'package:quiz_maker/views/home.dart';
import 'package:quiz_maker/widgets/widgets.dart';
import 'package:http/http.dart' as http;

class MailQuiz extends StatefulWidget {
  final int score;

  MailQuiz(this.score);

  @override
  _MailQuizState createState() => _MailQuizState();
}
// "https://quiz-maker-v1.herokuapp.com/sendMail"

class _MailQuizState extends State<MailQuiz> {
  final _formkey = GlobalKey<FormState>();
  bool _isLoading = false;
  String val, email, name, regNo;
  UserModel _userModel;

  TextEditingController nameController = new TextEditingController();
  TextEditingController regNoController = new TextEditingController();
  TextEditingController lectureController = new TextEditingController();
  TextEditingController studentController = new TextEditingController();

  Future<UserModel> sendScore(String name, String regNo, String results,
      String lecturerEmail, String studentEmail) async {
    var response = await http
        .post(Uri.https('quiz-maker-v1.herokuapp.com', 'sendMail'), body: {
      "name": name,
      "regNo": regNo,
      "results": results,
      "lecturerEmail": lecturerEmail,
      "studentEmail": studentEmail
    });
    var data = response.body;
    print(data);

    if (response.statusCode == 200) {
      String responseString = response.body;
      userModelFromJson(responseString);
    } else
      return null;
  }

  // mailQuiz() {
  //   if (_formkey.currentState.validate()) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //   } else if (val != null) {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }
  showAlertDialog(BuildContext context) {
    Widget continueButton = TextButton(
      child: Text("Ok",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w800)),
      onPressed: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      },
    );
    AlertDialog signOutDialog = AlertDialog(
      title: Text("Mail Score"),
      content: Text("Score sent Successfully!"),
      actions: [
        continueButton,
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return signOutDialog;
        });
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
              child: SingleChildScrollView(
                child: Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Image.asset(
                          'lib/images/quizzlogo.jpg',
                          width: 250,
                          height: 150,
                        ),
                        Text("Mail Your Score",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500)),
                        SizedBox(height: 15),
                        TextFormField(
                          validator: (val) {
                            if (val.isEmpty) {
                              return "Enter Your name";
                            }
                            return null;
                          },
                          controller: nameController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.account_box),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                            labelText: "Name",
                            // enabled: false,
                          ),
                          onChanged: (val) {
                            name = val;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          validator: (val) {
                            if (val.isEmpty) {
                              return "Enter your Reg Number";
                            } else if (!val.contains("/")) {
                              return "Enter a valid Reg Number";
                            }
                            return null;
                          },
                          controller: regNoController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.format_list_numbered),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                            labelText: "RegNo",
                            // enabled: false,
                          ),
                          onChanged: (val) {
                            regNo = val;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          initialValue: widget.score.toString(),
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
                          controller: lectureController,
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
                        SizedBox(height: 20),
                        TextFormField(
                          validator: (val) {
                            if (val.isEmpty) {
                              return "Enter Student`s email";
                            } else if (!val.contains("@")) {
                              return "Enter a valid email";
                            }
                            return null;
                          },
                          controller: studentController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                            labelText: "Student`s mail",
                            enabled: true,
                          ),
                          onChanged: (val) {
                            email = val;
                          },
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () async {
                            if (_formkey.currentState.validate()) {
                              String name = nameController.text;
                              String regNo = regNoController.text;
                              String results = widget.score.toString();
                              String lecturerEmail = lectureController.text;
                              String studentEmail = studentController.text;

                              UserModel user = await sendScore(name, regNo,
                                  results, lecturerEmail, studentEmail);

                              setState(() {
                                _userModel = user;
                                showAlertDialog(context);
                              });
                            } else {}
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
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              )),
    );
  }
}
