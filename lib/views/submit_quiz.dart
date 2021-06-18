
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:quiz_maker/components/text_fields.dart';
import 'package:quiz_maker/widgets/widgets.dart';

class SubmitQuiz extends StatefulWidget {
  @override
  _SubmitQuizState createState() => _SubmitQuizState();
}

class _SubmitQuizState extends State<SubmitQuiz> {
  final _formKey = GlobalKey<FormState>();

  // String score = widget.correctAnswer;

  bool _enableBtn = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  // @override
  // void dispose() {
  //   super.dispose();
  //   emailController.dispose();
  //   subjectController.dispose();
  //   messageController.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black54),
      ),
      body: Form(
        key: _formKey,
        onChanged: (() {
          setState(() {
            _enableBtn = _formKey.currentState.validate();
          });
        }),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFields(
                  controller: subjectController,
                  name: "Your Reg No",
                  validator: ((value) {
                    if (value.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  })),
              TextFields(
                  controller: emailController,
                  name: "Lecturer`s Email",
                  validator: ((value) {
                    if (value.isEmpty) {
                      return 'Email is required';
                    } else if (!value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  })),
              TextFields(
                  controller: messageController,
                  name: 'Score',
                  validator: ((value) {
                    if (value.isEmpty) {
                      setState(() {
                        _enableBtn = true;
                        messageController.text = 'Score: ';
                      });
                      return 'Message is Required';
                    }
                    return null;
                  }),
                  maxLines: null,
                  type: TextInputType.multiline),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 25),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed))
                              return Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.5);
                            else if (states.contains(MaterialState.disabled))
                              return Colors.grey;
                            return Colors.blue; // Use the component's default.
                          },
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ))),
                    onPressed: _enableBtn
                        ? (() async {
                            final Email email = Email(
                              body: messageController.text,
                              subject: subjectController.text,
                              recipients: [emailController.text],
                              isHTML: false,
                            );
                            await FlutterEmailSender.send(email);
                          })
                        : null,
                    child: Text('Submit'),
                  )),
            ],
          ),
      ),
    );
  }
}
