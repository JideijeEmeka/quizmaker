import 'package:flutter/material.dart';
import 'package:quiz_maker/views/MailQuiz.dart';
import 'package:quiz_maker/widgets/widgets.dart';

class Results extends StatefulWidget {
  final int correct, incorrect, total;

  Results(
      {@required this.correct, @required this.incorrect, @required this.total});

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${widget.correct}/${widget.total}",
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "You answered ${widget.correct} questions correctly and selected ${widget.incorrect} incorrect options",
                style: TextStyle(fontSize: 17, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 14,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MailQuiz(widget.correct)));
                  },
                  child: blueButton(
                      context: context,
                      label: "Mail your Score",
                      buttonWidth: MediaQuery.of(context).size.width / 2))
            ],
          ),
        ),
      ),
    );
  }
}
