import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../models/questions.dart';

class TakeQuiz extends StatefulWidget {
  const TakeQuiz({Key? key}) : super(key: key);

  @override
  State<TakeQuiz> createState() => _TakeQuizState();
}

class _TakeQuizState extends State<TakeQuiz> {
  String? quizId;
  int totalPoints = 0;
  int achievedPoints = 0;
  Map<int, String> _selectedAnswers = {};
  List<Questions> questions = [];
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference results =
      FirebaseFirestore.instance.collection('results');
  CollectionReference questionsRef =
      FirebaseFirestore.instance.collection('questions');

  @override
  void initState() {
    super.initState();
    quizId = Get.arguments['quizId'];
    getTotalPoints();
  }

  void getTotalPoints() async {
    questionsRef.where(FieldPath.documentId, isEqualTo: quizId).get().then(
      (value) {
        value.docs.forEach((element) {
          totalPoints = element['points'];
        });
      },
    );
  }

  void submitResult() async {
    int questionPoint = totalPoints ~/ questions.length;
    _selectedAnswers.forEach((key, value) async {
      if (value == questions[key].correctAnswer) {
        achievedPoints += questionPoint;
      }
    });

    User? user = auth.currentUser;
    //results -> uer id -> quiz id -> totalPoints, achievedPoints
    //if results not exist, create new one
    results = FirebaseFirestore.instance.collection('results');
    results.doc(user!.uid).collection('results').doc(quizId).set({
      'totalPoints': totalPoints,
      'achievedPoints': achievedPoints,
      'quizId': quizId,
    });

    Get.snackbar(
      'Quiz Results',
      'You got $achievedPoints correct answers out of $totalPoints',
      backgroundColor: Colors.white,
      snackPosition: SnackPosition.TOP,
      mainButton: TextButton(
        onPressed: () {
          Get.back();
        },
        child: const Text(
          'Close',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );

    achievedPoints = 0;
    await Future.delayed(const Duration(seconds: 2));
    Get.offAllNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF0F1B47),
                    Color(0xFFE18D5B),
                  ],
                ),
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    'Questions'.text.xl4.white.make(),
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('questions')
                          .where(FieldPath.documentId, isEqualTo: quizId)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Something went wrong');
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text('Loading');
                        }
                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data() as Map<String, dynamic>;
                              questions = List<Questions>.from(data['questions']
                                  .map((x) => Questions.fromJson(x)));
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:
                                    List.generate(questions.length, (index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      questions[index]
                                          .question
                                          .text
                                          .xl4
                                          .white
                                          .make(),
                                      StatefulBuilder(
                                        builder: (context, setState) {
                                          return Column(
                                            children: [
                                              RadioListTile(
                                                fillColor:
                                                    MaterialStateProperty.all(
                                                        Colors.white),
                                                title: questions[index]
                                                    .optionA
                                                    .text
                                                    .white
                                                    .make(),
                                                value: questions[index].optionA,
                                                groupValue:
                                                    _selectedAnswers[index],
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectedAnswers[index] =
                                                        value.toString();
                                                  });
                                                },
                                              ),
                                              RadioListTile(
                                                fillColor:
                                                    MaterialStateProperty.all(
                                                        Colors.white),
                                                title: questions[index]
                                                    .optionB
                                                    .text
                                                    .white
                                                    .make(),
                                                value: questions[index].optionB,
                                                groupValue:
                                                    _selectedAnswers[index],
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectedAnswers[index] =
                                                        value.toString();
                                                  });
                                                },
                                              ),
                                              RadioListTile(
                                                fillColor:
                                                    MaterialStateProperty.all(
                                                        Colors.white),
                                                title: questions[index]
                                                    .optionC
                                                    .text
                                                    .white
                                                    .make(),
                                                value: questions[index].optionC,
                                                groupValue:
                                                    _selectedAnswers[index],
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectedAnswers[index] =
                                                        value.toString();
                                                  });
                                                },
                                              ),
                                              RadioListTile(
                                                fillColor:
                                                    MaterialStateProperty.all(
                                                        Colors.white),
                                                title: questions[index]
                                                    .optionD
                                                    .text
                                                    .white
                                                    .make(),
                                                value: questions[index].optionD,
                                                groupValue:
                                                    _selectedAnswers[index],
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectedAnswers[index] =
                                                        value.toString();
                                                  });
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                }),
                              );
                            }).toList(),
                          ),
                        );
                      },
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        submitResult();
                      },
                      child: 'Submit Quiz'.text.make(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
