
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class Quizzes extends StatefulWidget {
  const Quizzes({super.key});

  @override
  State<Quizzes> createState() => _QuizzesState();
}

class _QuizzesState extends State<Quizzes> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start, // Change is here!
          children: [
            'Quizzes'.text.xl4.white.make(),
            //button to add quiz
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed('/add_quiz');
                  },
                  child: const Text('Create your own quiz'),
                ),
                //generate with ai

              ],
            ),
            //list of quizzes
            //questions -> id -> title, due date, points question, options, correctAnswer
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('questions').snapshots(),
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
                    return ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      textColor: Colors.white,
                      titleTextStyle: const TextStyle(
                        fontSize: 20,
                      ),
                      subtitleTextStyle: const TextStyle(
                        fontSize: 15,
                      ),
                      leadingAndTrailingTextStyle: const TextStyle(
                        fontSize: 20,
                      ),
                      title: Text('Title: ${data['title']}'),
                      subtitle: Text('Due Date: ${data['dueDate']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Points: ${data['points']}'),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              FirebaseFirestore.instance.collection('questions').doc(document.id).delete();
                            },
                          ),
                        ],
                      ),
                      onTap: () {
                        print(document.id);
                        Get.toNamed('/quiz_details', arguments: {
                          'quizId': document.id,
                        });
                      },
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ).p8(),
      ),
    );
  }
}
