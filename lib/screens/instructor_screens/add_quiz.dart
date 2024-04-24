import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzity/models/quiz.dart';
import 'package:show_platform_date_picker/show_platform_date_picker.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../models/course.dart';

class AddQuiz extends StatefulWidget {
  const AddQuiz({super.key});

  @override
  State<AddQuiz> createState() => _AddQuizState();
}

class _AddQuizState extends State<AddQuiz> {
  DateTime selectedDate = DateTime.now();
  TextEditingController quizTitleController = TextEditingController();
  TextEditingController pointsController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  Course? _selectedCourse;
  final _formKey = GlobalKey<FormState>();
  List<Course> courses = [];
  CollectionReference coursesRef =
      FirebaseFirestore.instance.collection('courses');

  void getCourses() async {
    coursesRef.get().then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        Course course = Course(
          courseName: doc['courseName'],
          courseCode: doc['courseCode'],
          courseDescription: doc['courseDescription'],
          numberOfStudents: int.parse(doc['numberOfStudents']),
        );
        setState(() {
          courses.add(course);
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCourses();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ShowPlatformDatePicker platformDatePicker =
        ShowPlatformDatePicker(buildContext: context);
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
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      'Create Quiz'.text.xl4.white.make(),
                      //dropdown for courses
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white, borderRadius: BorderRadius.circular(10)),
                        child: DropdownButtonFormField<Course>(
                          value: _selectedCourse,
                          onChanged: (Course? course) {
                            setState(() {
                              _selectedCourse = course;
                            });
                          },
                          items: courses
                              .map(
                                (Course course) => DropdownMenuItem<Course>(
                                  value: course,
                                  child: Text(course.courseName),
                                ),
                              )
                              .toList(),
                          decoration: InputDecoration(
                            labelText: 'Select Course',
                            //list background color

                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      //quiz title

                      TextFormField(
                        controller: quizTitleController,
                        decoration: InputDecoration(
                          labelText: 'Quiz Title',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please provide Quiz title';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      //points
                      TextFormField(
                        controller: pointsController,
                        decoration: InputDecoration(
                          labelText: 'Points',
                          labelStyle: const TextStyle(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please provide points';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        child: TextFormField(
                          readOnly: true,
                          controller: dueDateController,
                          decoration: InputDecoration(
                            labelText: 'Choose Due Date',
                            labelStyle: const TextStyle(
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          onTap: () async {
                            final newSelectedDatePicker =
                                await platformDatePicker.showPlatformDatePicker(
                              context,
                              selectedDate,
                              DateTime(2024),
                              DateTime.now().add(const Duration(days: 3650)),
                            );
                            setState(() {
                              dueDateController.text =
                                  newSelectedDatePicker.toString();
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Quiz quiz = Quiz(
                                title: quizTitleController.text,
                                points: int.parse(pointsController.text),
                                dueDate: dueDateController.text,
                              );
                              quiz.courseName = _selectedCourse!.courseName;
                              Get.toNamed('/add_question', arguments: {
                                'quiz': quiz,
                              });
                            }
                          },
                          child: Text('Continue'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
