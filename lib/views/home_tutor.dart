import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_maker/services/database.dart';
import 'package:quiz_maker/views/play_quiz.dart';
import 'package:quiz_maker/views/play_quizTutor.dart';
import 'package:quiz_maker/views/signin_tutor.dart';
import 'package:quiz_maker/widgets/widgets.dart';

import 'create_quiz.dart';

class Home_Tutor extends StatefulWidget {
  @override
  _Home_TutorState createState() => _Home_TutorState();
}

class _Home_TutorState extends State<Home_Tutor> {
  Stream quizStream;
  DatabaseService databaseService = new DatabaseService();
  FirebaseAuth auth = FirebaseAuth.instance;

  signOut() async {
    await auth.signOut();
  }

  Widget quizList() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: StreamBuilder(
          stream: quizStream,
          builder: (context, snapshot) {
            // if(snapshot.data == null) return CircularProgressIndicator();
            return snapshot.data == null
                ? Container()
                : ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      return QuizTile(
                        imgUrl: snapshot.data.docs[index]["quizImgUrl"],
                        desc: snapshot.data.docs[index]["quizDesc"],
                        title: snapshot.data.docs[index]["quizTitle"],
                        quizid: snapshot.data.docs[index]["quizId"],
                        quizSession: snapshot.data.docs[index]["quizSession"],
                        quizSemester: snapshot.data.docs[index]["quizSemester"],
                      );
                    });
          }),
    );
  }

  @override
  void initState() {
    databaseService.getQuizesData().then((val) {
      setState(() {
        quizStream = val;
      });
    });
    super.initState();
  }

  //SignOut AlertDialog
  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text("Cancel",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.w800)),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w800)),
      onPressed: () {
        signOut();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => SignIn_Tutor()),
            (route) => false);
      },
    );
    AlertDialog signOutDialog = AlertDialog(
      title: Text("Sign Out"),
      content: Text("Are you sure you want to Signout?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return signOutDialog;
        });
  }

  // DeleteQuiz AlertDialog
  showDeleteAlertDialog(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        title: appBar(context),
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Hello Tutor,",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                " Welcome!",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text("to Unn QuizMaker App",
              style: TextStyle(
                fontSize: 16,
              )),
          SizedBox(
            height: 8,
          ),
          GestureDetector(
            onTap: () {
              showAlertDialog(context);
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 2 - 70,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    )
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sign Out",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.logout,
                    size: 17,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: quizList(),
          ),
          SizedBox(height: 13),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              appBar(context),
              Text("(Powered by Unn...)",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ))
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateQuiz()));
        },
        label: Text("Create New Quiz"),
        icon: Icon(Icons.add),
      ),
    );
  }
}

class QuizTile extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String desc;
  final String quizid;
  final String quizSession;
  final String quizSemester;

  QuizTile({
    @required this.imgUrl,
    @required this.title,
    @required this.desc,
    @required this.quizid,
    @required this.quizSession,
    @required this.quizSemester,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PlayQuizTutor(quizId: quizid)));
      },
      onLongPress: () {
        showDeleteAlertDialog(context);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        height: 150,
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imgUrl,
                  width: MediaQuery.of(context).size.width - 48,
                  fit: BoxFit.cover,
                )),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(2, 2),
                            blurRadius: 2.2,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Text(
                    desc,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(2, 2),
                            blurRadius: 2.2,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ]),),
                  SizedBox(
                    height: 1,
                  ),
                  Text(
                    "Session: " + quizSession,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(2, 2),
                            blurRadius: 2.2,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ]),),
                  SizedBox(
                    height: 1,
                  ),
                  Text(
                    "Semester: " + quizSemester,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(2, 2),
                            blurRadius: 2.2,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ]),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  deleteQuiz() async {
    await FirebaseFirestore.instance
        .collection("Quiz")
        .where("quizId", isEqualTo: quizid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        FirebaseFirestore.instance
            .collection("Quiz")
            .doc(element.id)
            .delete()
            .then((value) {
          print("success!");
        });
      });
    });
  }

  void showDeleteAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text("Cancel",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w800)));
    Widget continueButton = TextButton(
        onPressed: () {
          Navigator.pop(context);
          deleteQuiz();
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => DeleteQuiz()));
        },
        child: Text("Continue",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w800)));
    AlertDialog deleteDialog = AlertDialog(
      title: Text("Delete Quiz"),
      content: Text("Are you Sure you want to delete this Quiz?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return deleteDialog;
        });
  }
}
