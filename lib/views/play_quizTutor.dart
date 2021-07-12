import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_maker/models/question_model.dart';
import 'package:quiz_maker/services/database.dart';
import 'package:quiz_maker/views/quiz_play_widgets.dart';
import 'package:quiz_maker/views/result.dart';
import 'package:quiz_maker/widgets/widgets.dart';

class PlayQuizTutor extends StatefulWidget {
  final String quizId;
  PlayQuizTutor({this.quizId});

  @override
  _PlayQuizTutorState createState() => _PlayQuizTutorState();
}

int total = 0;
int _correctAnswer = 0;
int _inCorrectAnswer = 0;
int _notAttempted = 0;

class _PlayQuizTutorState extends State<PlayQuizTutor> {
  final interval = const Duration(seconds: 1);

  final int timerMaxSeconds = 60;

  int currentSeconds = 0;

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}:${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  startTimeout([int milliseconds]) {
    var duration = interval;
    Timer.periodic(duration, (timer) {
      if (questionsSnapshot != null)
        setState(() {
          print(timer.tick);
          currentSeconds = timer.tick;
          if (timer.tick >= timerMaxSeconds) {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => Results(
            //             correct: _correctAnswer,
            //             incorrect: _inCorrectAnswer,
            //             total: total)));
            timer.cancel();
          }
        });
    });
  }

  bool shuffled = false;

  DatabaseService databaseService = new DatabaseService();
  QuerySnapshot questionsSnapshot;

  QuestionModel getQuestionModelFromDataSnapshot(
      DocumentSnapshot questionSnapshot) {
    QuestionModel questionModel = new QuestionModel();
    Map<String, dynamic> optionsMap = questionSnapshot.data();
    questionModel.question = optionsMap["question"];

    List<String> options = [
      optionsMap['option1'],
      optionsMap["option2"],
      optionsMap["option3"],
      optionsMap["option4"],
    ];

    if (!shuffled) {
      options.shuffle();
      shuffled = true;
    }

    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctOption = optionsMap['option1'];
    questionModel.answered = false;

    return questionModel;
  }

  @override
  void initState() {
    print("${widget.quizId}");
    databaseService.getQuizData(widget.quizId).then((value) {
      questionsSnapshot = value;
      _notAttempted = 0;
      _correctAnswer = 0;
      _inCorrectAnswer = 0;
      total = questionsSnapshot.docs.length;
      print("$total this is total");
      setState(() {});
    });
    startTimeout();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black54),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              timerText,
              style: TextStyle(color: Colors.blue, fontSize: 25),
            ),
            SizedBox(
              height: 15,
            ),
            questionsSnapshot == null
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: questionsSnapshot.docs.length,
                    itemBuilder: (context, index) {
                      return QuizPlayTile(
                          questionModel: getQuestionModelFromDataSnapshot(
                              questionsSnapshot.docs[index]),
                          index: index);
                    })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          
        },
        icon: Icon(Icons.done),
        label: Text("Submit Your Quiz")
      ),
    );
  }
}

class QuizPlayTile extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;
  QuizPlayTile({this.questionModel, this.index});

  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelected = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Question${widget.index + 1}:  ${widget.questionModel.question}",
              style: TextStyle(fontSize: 17, color: Colors.black87),
            ),
            SizedBox(
              height: 12,
            ),
            GestureDetector(
              onTap: () {
                if (!widget.questionModel.answered) {
                  //correct Answer
                  if (widget.questionModel.option1 ==
                      widget.questionModel.correctOption) {
                    optionSelected = widget.questionModel.option1;
                    widget.questionModel.answered = true;
                    _correctAnswer = _correctAnswer + 1;
                    _notAttempted = _notAttempted - 1;
                    setState(() {});
                  } else {
                    optionSelected = widget.questionModel.option1;
                    widget.questionModel.answered = true;
                    _inCorrectAnswer = _inCorrectAnswer + 1;
                    _notAttempted = _notAttempted - 1;
                    setState(() {});
                  }
                }
              },
              child: OptionTile(
                correctAnswer: widget.questionModel.correctOption,
                description: widget.questionModel.option1,
                option: "A",
                optionSelected: optionSelected,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            GestureDetector(
              onTap: () {
                if (!widget.questionModel.answered) {
                  //correct Answer
                  if (widget.questionModel.option2 ==
                      widget.questionModel.correctOption) {
                    optionSelected = widget.questionModel.option2;
                    widget.questionModel.answered = true;
                    _correctAnswer = _correctAnswer + 1;
                    _notAttempted = _notAttempted - 1;
                    setState(() {});
                  } else {
                    optionSelected = widget.questionModel.option2;
                    widget.questionModel.answered = true;
                    _inCorrectAnswer = _inCorrectAnswer + 1;
                    _notAttempted = _notAttempted - 1;
                    print("${widget.questionModel.correctOption}");
                    setState(() {});
                  }
                }
              },
              child: OptionTile(
                correctAnswer: widget.questionModel.correctOption,
                description: widget.questionModel.option2,
                option: "B",
                optionSelected: optionSelected,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            GestureDetector(
              onTap: () {
                if (!widget.questionModel.answered) {
                  //correct Answer
                  if (widget.questionModel.option3 ==
                      widget.questionModel.correctOption) {
                    optionSelected = widget.questionModel.option3;
                    widget.questionModel.answered = true;
                    _correctAnswer = _correctAnswer + 1;
                    _notAttempted = _notAttempted - 1;
                    setState(() {});
                  } else {
                    optionSelected = widget.questionModel.option3;
                    widget.questionModel.answered = true;
                    _inCorrectAnswer = _inCorrectAnswer + 1;
                    _notAttempted = _notAttempted - 1;
                    setState(() {});
                  }
                }
              },
              child: OptionTile(
                correctAnswer: widget.questionModel.correctOption,
                description: widget.questionModel.option3,
                option: "C",
                optionSelected: optionSelected,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            GestureDetector(
              onTap: () {
                if (!widget.questionModel.answered) {
                  //correct Answer
                  if (widget.questionModel.option4 ==
                      widget.questionModel.correctOption) {
                    optionSelected = widget.questionModel.option4;
                    widget.questionModel.answered = true;
                    _correctAnswer = _correctAnswer + 1;
                    _notAttempted = _notAttempted - 1;
                    setState(() {});
                  } else {
                    optionSelected = widget.questionModel.option4;
                    widget.questionModel.answered = true;
                    _inCorrectAnswer = _inCorrectAnswer + 1;
                    _notAttempted = _notAttempted - 1;
                    setState(() {});
                  }
                }
              },
              child: OptionTile(
                correctAnswer: widget.questionModel.correctOption,
                description: widget.questionModel.option4,
                option: "D",
                optionSelected: optionSelected,
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
