import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:velocity_x/velocity_x.dart';

class AddCourse extends StatefulWidget {
  const AddCourse({super.key});

  @override
  State<AddCourse> createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController courseNameController = TextEditingController();
  TextEditingController courseCodeController = TextEditingController();
  TextEditingController courseDescriptionController = TextEditingController();
  TextEditingController numberOfStudentsController = TextEditingController();
  CollectionReference courses =
      FirebaseFirestore.instance.collection('courses');
  ProgressDialog? _progressDialog;

  void addCourse() {
    _progressDialog = ProgressDialog(context: context);
    _progressDialog!.show(max: 100, msg: 'Adding Course');
    courses.add({
      'courseName': courseNameController.text,
      'courseCode': courseCodeController.text,
      'courseDescription': courseDescriptionController.text,
      'numberOfStudents': numberOfStudentsController.text,
    }).then((value) {
      _progressDialog!.close();
      Get.back();
      Get.snackbar(
        'Course Added',
        'Course has been added successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }).catchError((error) {
      _progressDialog!.close();
      Get.back();
      Get.snackbar(
        'Error Adding Course',
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
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    'Add Course'.text.xl4.white.make(),
                    TextFormField(
                      controller: courseNameController,
                      decoration: InputDecoration(
                        labelText: 'Course Name',
                        labelStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter course name';
                        }
                        return null;
                      },
                    ).p8(),
                    TextFormField(
                      controller: courseCodeController,
                      decoration: InputDecoration(
                        labelText: 'Course Code',
                        labelStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter course code';
                        }
                        return null;
                      },
                    ).p8(),
                    TextFormField(
                      controller: courseDescriptionController,
                      decoration: InputDecoration(
                        labelText: 'Course Description',
                        labelStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter course description';
                        }
                        return null;
                      },
                    ).p8(),
                    TextFormField(
                      controller: numberOfStudentsController,
                      decoration: InputDecoration(
                        labelText: 'Number of Students',
                        labelStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter number of students';
                        }
                        return null;
                      },
                    ).p8(),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          addCourse();
                        }
                      },
                      child: const Text('Add Course'),
                    ).p8(),
                  ],
                ).p8(),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
