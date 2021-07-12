import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_maker/services/database.dart';
import 'package:quiz_maker/widgets/widgets.dart';
import 'package:random_string/random_string.dart';

import 'addquestion.dart';

class CreateQuiz extends StatefulWidget {
  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formKey = GlobalKey<FormState>();
  String quizImageUrl,
      quizTitle,
      quizDescription,
      quizId,
      quizSession,
      quizSemester;
  DatabaseService databaseService = new DatabaseService();
  bool _isLoading = false;

  createQuizOnline() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      quizId = randomAlphaNumeric(16);

      Map<String, String> quizMap = {
        "quizId": quizId,
        "quizImgUrl": quizImageUrl,
        "quizTitle": quizTitle,
        "quizDesc": quizDescription,
        "quizSession": quizSession,
        "quizSemester": quizSemester,
      };

      await databaseService.addQuizData(quizMap, quizId).then((value) {
        setState(() {
          _isLoading = false;
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => AddQuestion(quizId)));
        });
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
        iconTheme: IconThemeData(color: Colors.black87),
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
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Spacer(),
                    Image.asset(
                      'lib/images/quizzlogo.jpg',
                      width: 250,
                      height: 150,
                    ),
                    Text("Create a New Quiz",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 18,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500)),
                    SizedBox(height: 12),
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? "Enter Image Url" : null,
                      decoration: InputDecoration(
                        hintText: "Quiz Image Url",
                      ),
                      onChanged: (val) {
                        quizImageUrl = val;
                      },
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? "Enter Course Code" : null,
                      decoration: InputDecoration(
                        hintText: "Course Code",
                      ),
                      onChanged: (val) {
                        quizTitle = val;
                      },
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? "Enter Course Title" : null,
                      decoration: InputDecoration(
                        hintText: "Course Title",
                      ),
                      onChanged: (val) {
                        quizDescription = val;
                      },
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Enter Academic Session";
                        } else if (!val.contains("/")) {
                          return "Please enter a valid academic session";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Academic Session (e.g 2018/19)",
                      ),
                      onChanged: (val) {
                        quizSession = val;
                      },
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      validator: (val) => val.isEmpty ? "Enter Semester" : null,
                      decoration: InputDecoration(
                        hintText: "Semester",
                      ),
                      onChanged: (val) {
                        quizSemester = val;
                      },
                    ),
                    Spacer(),
                    GestureDetector(
                        onTap: () {
                          createQuizOnline();
                        },
                        child:
                            blueButton(context: context, label: "Create Quiz")),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
