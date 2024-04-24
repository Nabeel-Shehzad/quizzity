import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:velocity_x/velocity_x.dart';

class Courses extends StatefulWidget {
  const Courses({super.key});

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start, // Change is here!
        children: [
          'Courses'.text.xl4.white.make(),
          //button to add course
          ElevatedButton(
            onPressed: () {
              Get.toNamed('/add_course');
            },
            child: const Text('Add Course'),
          ),
          //list of courses
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('courses').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return 'Something went wrong'.text.make();
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Expanded(
                child: ListView(
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                    return ListTile(
                      title: data['courseName'].toString().text.white.make(),
                      subtitle: data['courseDescription'].toString().text.white.make(),
                      //add edit and delete icon button
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.green),
                            onPressed: () {
                              //pass document id and data
                              Get.toNamed('/edit_course', arguments: {
                                'docId': document.id,
                                'courseName': data['courseName'],
                                'courseCode': data['courseCode'],
                                'courseDescription': data['courseDescription'],
                                'numberOfStudents': data['numberOfStudents'],
                              });
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              FirebaseFirestore.instance.collection('courses').doc(document.id).delete().then((value) {
                                Get.snackbar(
                                  'Course Deleted',
                                  'Course has been deleted successfully',
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white,
                                );
                              }).catchError((error) {
                                Get.snackbar(
                                  'Error Deleting Course',
                                  error.toString(),
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                );
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ],
      ).p8(),
    );
  }
}
