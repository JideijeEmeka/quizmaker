import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:quiz_maker/services/database.dart';
import 'package:quiz_maker/views/play_quiz.dart';
import 'package:quiz_maker/widgets/widgets.dart';

import 'create_quiz.dart';

class Home_Tutor extends StatefulWidget {
  @override
  _Home_TutorState createState() => _Home_TutorState();
}

class _Home_TutorState extends State<Home_Tutor> {
  Stream quizStream;
  DatabaseService databaseService = new DatabaseService();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
        elevation: 0.0,
      ),
      body: quizList(),
      // body: Column(
      //   children: [
      //     Row(
      //       children: [
      //         Text('Hello,', style: TextStyle(color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold)),
      //         Text('Welcome\n', style: TextStyle(color: Colors.black54, fontSize: 30,)),
      //         Text('to Unn QuizMaker App', style: TextStyle(color: Colors.black54, fontSize: 20,))

      //     ]),
      //         quizList(),
      //         Text('Create Quiz', style: TextStyle(color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold,),)
      //   ,
      //       ],
      // ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateQuiz()));
        },
      ),
    );
  }
}

class QuizTile extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String desc;
  final String quizid;

  QuizTile(
      {@required this.imgUrl,
      @required this.title,
      @required this.desc,
      @required this.quizid});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PlayQuiz(quizId: quizid)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
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
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    desc,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
