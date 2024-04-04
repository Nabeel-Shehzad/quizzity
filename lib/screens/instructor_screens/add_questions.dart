import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzity/models/quiz.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../models/questions.dart';

class AddQuestions extends StatefulWidget {
  const AddQuestions({super.key});

  @override
  State<AddQuestions> createState() => _AddQuestionsState();
}

class _AddQuestionsState extends State<AddQuestions> {
  Quiz? quiz;
  List<Questions> questions = [];
  final _formKey = GlobalKey<FormState>();
  TextEditingController questionController = TextEditingController();
  TextEditingController option1Controller = TextEditingController();
  TextEditingController option2Controller = TextEditingController();
  TextEditingController option3Controller = TextEditingController();
  TextEditingController option4Controller = TextEditingController();
  TextEditingController correctOptionController = TextEditingController();
  CollectionReference questionsCollection =
      FirebaseFirestore.instance.collection('questions');

  @override
  void initState() {
    super.initState();
    quiz = Get.arguments['quiz'];
  }

  //save to firebase
  void submitQuiz() {
    String quizId = questionsCollection.doc().id;
    questionsCollection.doc(quizId).set({
      'title': quiz!.title,
      'points': quiz!.points,
      'dueDate': quiz!.dueDate,
      'courseName': quiz!.courseName,
      'questions': questions.map((question) => question.toMap()).toList(),
    }).then((value) {
      Get.back();
      Get.snackbar(
        'Quiz Added',
        'Quiz have been added successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }).catchError((error) {
      Get.back();
      Get.snackbar(
        'Error Adding Questions',
        error.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    });
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      'Add Questions'.text.xl4.white.make(),
                      const SizedBox(
                        height: 10,
                      ),
                      //question
                      TextFormField(
                        controller: questionController,
                        decoration: const InputDecoration(
                          labelText: 'Question',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please provide question';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //option 1
                      TextFormField(
                        controller: option1Controller,
                        decoration: const InputDecoration(
                          labelText: 'Option 1',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please provide option 1';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //option 2
                      TextFormField(
                        controller: option2Controller,
                        decoration: const InputDecoration(
                          labelText: 'Option 2',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please provide option 2';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //option 3
                      TextFormField(
                        controller: option3Controller,
                        decoration: const InputDecoration(
                          labelText: 'Option 3',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please provide option 3';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //option 4
                      TextFormField(
                        controller: option4Controller,
                        decoration: const InputDecoration(
                          labelText: 'Option 4',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please provide option 4';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //correct option
                      TextFormField(
                        controller: correctOptionController,
                        decoration: const InputDecoration(
                          labelText: 'Correct Option',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please provide correct option';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Questions question = Questions(
                              question: questionController.text,
                              optionA: option1Controller.text,
                              optionB: option2Controller.text,
                              optionC: option3Controller.text,
                              optionD: option4Controller.text,
                              correctAnswer: correctOptionController.text,
                            );
                            questions.add(question);
                            questionController.clear();
                            option1Controller.clear();
                            option2Controller.clear();
                            option3Controller.clear();
                            option4Controller.clear();
                            correctOptionController.clear();
                          }
                        },
                        child: const Text('Add Question'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          quiz!.questions = questions;
                          submitQuiz();
                          Get.offAllNamed('/instructor_home');
                        },
                        child: const Text('Save Questions'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
