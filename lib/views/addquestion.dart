import 'package:flutter/material.dart';
import 'package:quiz_maker/services/database.dart';
import 'package:quiz_maker/widgets/widgets.dart';

class AddQuestion extends StatefulWidget {

  final String quizId;
  AddQuestion(this.quizId);

  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {

  final _formKey = GlobalKey<FormState>();
  String question, option1, option2, option3, option4;
  bool _isLoading = false;
  DatabaseService databaseService = new DatabaseService();
   
  uploadQuestionData() {
    if(_formKey.currentState.validate()) {

      setState(() {
        _isLoading = true;
      });
      Map<String, String> questionMap = {
        "question" : question,
        "option1" : option1,
        "option2" : option2,
        "option3" : option3,
        "option4" : option4,
      };
         databaseService.addQuestionData(questionMap, widget.quizId).then((value) {
            setState(() {
              _isLoading = false;
            });
         });
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        iconTheme: IconThemeData(color: Colors.black87),
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
        elevation: 0.0,
      ),
      body: _isLoading ? Container(
        child: Center(child: CircularProgressIndicator(),),
      ) : Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              TextFormField(
                validator: (val) =>
                val.isEmpty ? "Enter Question" : null,
                decoration: InputDecoration(
                  hintText: "Question",
                ),
                onChanged: (val) {
                  question = val;
                },
              ),
              SizedBox(
                height: 6,
              ),
              TextFormField(
                validator: (val) =>
                val.isEmpty ? "Option1" : null,
                decoration: InputDecoration(
                  hintText: "option1 (Enter the Correct Answer)",
                ),
                onChanged: (val) {
                  option1 = val;
                },
              ),
              SizedBox(
                height: 6,
              ),
              TextFormField(
                validator: (val) =>
                val.isEmpty ? "Option2" : null,
                decoration: InputDecoration(
                  hintText: "option2",
                ),
                onChanged: (val) {
                  option2 = val;
                },
              ),
              TextFormField(
                validator: (val) =>
                val.isEmpty ? "Option3" : null,
                decoration: InputDecoration(
                  hintText: "option3",
                ),
                onChanged: (val) {
                  option3 = val;
                },
              ),
              TextFormField(
                validator: (val) =>
                val.isEmpty ? "Option4" : null,
                decoration: InputDecoration(
                  hintText: "option4",
                ),
                onChanged: (val) {
                  option4 = val;
                },
              ),
              Spacer(),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                  child: blueButton(context: context, label: "Submit", buttonWidth: MediaQuery.of(context).size.width/2 - 36)),
                  SizedBox(width: 24,),
                  GestureDetector(
                      onTap: () {
                        uploadQuestionData();
                      },
                      child: blueButton(context: context, label: "Add Question", buttonWidth: MediaQuery.of(context).size.width/2 - 36)),
                ],
              ),
              SizedBox(height: 60,),
            ],
          ),
        ),
      )
    );
  }
}
