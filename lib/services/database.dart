import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future<void> addQuizData(Map quizData, String quizId) async {
    await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .set(quizData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> addQuestionData(Map questionData, String quizId) async {
    await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .collection("QNA")
        .add(questionData)
        .catchError((e) {
      print(e);
    });
  }

  getQuizesData() async {
    return FirebaseFirestore.instance.collection("Quiz").snapshots();
  }

  // getMailData() async {
  //   return FirebaseFirestore.instance.collection("Mail").snapshots();
  // }

  getQuizData(String quizId) async {
    return await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .collection("QNA")
        .get();
  }

  updateQuizData(String quizId, newValues) {
    FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .update(newValues)
        .catchError((e) {
      print(e);
    });
  }
}
