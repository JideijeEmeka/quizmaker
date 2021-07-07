
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_maker/services/database.dart';
import 'package:quiz_maker/views/play_quiz.dart';
import 'package:quiz_maker/views/signin.dart';
import 'package:quiz_maker/widgets/widgets.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream quizStream;
  DatabaseService databaseService = new DatabaseService();
  FirebaseAuth auth = FirebaseAuth.instance;

  signOut() async {
    await auth.signOut();
  }

  Widget quizList() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25,),
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

  //AlertDialog
  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text("Cancel", style: TextStyle(color: Colors.red, fontWeight: FontWeight.w800)),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w800)),
      onPressed: () {
        signOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SignIn()),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                "Hello,",
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
              Text("(Powered by Unn...)", style: TextStyle(fontStyle: FontStyle.italic,)),
            ],
          ),
        ],
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
        margin: EdgeInsets.only(bottom: 10),
        height: 150,
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imgUrl,
                  width: MediaQuery.of(context).size.width - 48,
                  fit: BoxFit.cover,
                )),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                // color: Colors.white,
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
                        fontWeight: FontWeight.bold, shadows: <Shadow> [
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
                        color: Colors.black54,
                        fontSize: 15,
                        fontWeight: FontWeight.w800),
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
