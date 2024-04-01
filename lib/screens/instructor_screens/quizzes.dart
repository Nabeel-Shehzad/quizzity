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
              ElevatedButton(
                onPressed: () {
                  Get.toNamed('/add_quiz');
                },
                child: const Text('Generate with AI'),
              ),
            ],
          )
          //list of quizzes
          // StreamBuilder<QuerySnapshot>(
          //   stream: FirebaseFirestore.instance.collection('quizzes').snapshots(),
          //   builder: (context, snapshot) {
          //     if (snapshot.hasError) {
          //       return 'Something went wrong'.text.make();
          //     }

          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     }
          //     return Expanded(
          //       child: ListView(
          //         children: snapshot.data!.docs.map((DocumentSnapshot document) {
          //           Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          //           return ListTile(
          //             title: data['quizName'].toString().text.white.make(),
          //             subtitle: data['quizDescription'].toString().text.white.make(),
          //             //add edit and delete icon button
          //             trailing: Row(
          //               mainAxisSize: MainAxisSize.min,
          //               children: [
          //                 IconButton(
          //                   icon: const Icon(Icons.edit, color: Colors.green),
          //                   onPressed: () {
          //                     //pass document id and data
          //                     Get.toNamed('/edit_quiz', arguments: {
          //                       'id': document.id,
          //                       'data': data,
          //                     });
          //                   },
          //                 ),
          //                 IconButton(
          //                   icon: const Icon(Icons.delete, color: Colors.red),
          //                   onPressed: () {
          //                     //delete quiz
          //                     FirebaseFirestore.instance.collection('quizzes').doc(document.id).delete().then((value) {
          //                       Get.snackbar(
          //                         'Quiz Deleted',
          //                         'Quiz has been deleted successfully',
          //                         backgroundColor: Colors.green,
          //                         colorText: Colors.white,
          //                       );
          //                     }).catchError((error) {
          //                       Get.snackbar(
          //                         'Error Deleting Quiz',
          //
          //                         error.toString(),
          //                         backgroundColor: Colors.red,
          //                         colorText: Colors.white,
          //                       );
          //                     });
          //                   },
          //                 ),
          //               ],
          //             ),
          //           );
          //         }).toList(),
          //       ),
          //     );
          //   },
          // ),
        ],
      ).p8(),
    );
  }
}
