import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzity/models/questions.dart';
import 'package:velocity_x/velocity_x.dart';

class QuizDetails extends StatefulWidget {
  const QuizDetails({super.key});

  @override
  State<QuizDetails> createState() => _QuizDetailsState();
}

class _QuizDetailsState extends State<QuizDetails> {
  String? quizId;

  @override
  void initState() {
    super.initState();
    quizId = Get.arguments['quizId'];
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
                      //where document id is equal to quizId
                      stream: FirebaseFirestore.instance.collection('questions').where(FieldPath.documentId, isEqualTo: quizId).snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Something went wrong');
                        }
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Text('Loading');
                        }
                        return ListView(
                          shrinkWrap: true,
                          children: snapshot.data!.docs.map((DocumentSnapshot document) {
                            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                            //get questions array
                            List<Questions> questions =
                            List<Questions>.from(data['questions'].map((x) => Questions.fromJson(x)));

                            //return a ListView for each document
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: questions.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  textColor: Colors.white,
                                  title: Text('Question: ${questions[index].getQuestion}'),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Option A: ${questions[index].getOptionA}'),
                                      Text('Option B: ${questions[index].getOptionB}'),
                                      Text('Option C: ${questions[index].getOptionC}'),
                                      Text('Option D: ${questions[index].getOptionD}'),
                                      Text('Correct Answer: ${questions[index].getCorrectAnswer}'),
                                    ],
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ],
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
