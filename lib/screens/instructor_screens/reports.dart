import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class Reports extends StatefulWidget {
  const Reports({super.key});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  CollectionReference standings =
      FirebaseFirestore.instance.collection('results');
  FirebaseAuth auth = FirebaseAuth.instance;
  List<Map<String, dynamic>> userResults = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<List<String>> getUserIds() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    List<String> userIds = [];
    await users.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        userIds.add(doc.id);
      });
    });
    return userIds;
  }

  Future<void> getData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    List<String> userIds = await getUserIds();
    List<Map<String, dynamic>> results = [];

    //remove current user id from userIds
    userIds.remove(auth.currentUser!.uid);

    // Get data for each user
    for (String userId in userIds) {
      String username = await getUsername(userId); // Fetch username
      List<Map<String, dynamic>> userQuizResults = [];

      DocumentReference userDocRef = firestore.collection('results').doc(userId);
      QuerySnapshot querySnapshot = await userDocRef.collection('results').get();

      // Process quiz results for this user
      querySnapshot.docs.forEach((doc) {
        String quizId = doc.id;
        int achievedPoints = doc.get('achievedPoints');
        int totalPoints = doc.get('totalPoints');

        // Add quiz result to the list
        userQuizResults.add({
          'quizId': quizId,
          'achievedPoints': achievedPoints,
          'totalPoints': totalPoints,
        });
      });

      // Add user data to the overall list
      results.add({
        'username': username,
        'quizResults': userQuizResults,
      });
    }

    // Set state with the results
    setState(() {
      userResults = results;
    });
  }


  Future<String> getUsername(String userId) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (documentSnapshot.exists) {
        Map<String, dynamic>? data =
            documentSnapshot.data() as Map<String, dynamic>?;
        return '${data!['firstName']} ${data['lastName']}';
      } else {
        return '';
      }
    } catch (error) {
      print("Failed to get username: $error");
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  'Standings'.text.xl4.bold.makeCentered().p16(),
                  const SizedBox(height: 20),
                  // Display user results in a ListView
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: userResults.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> userData = userResults[index];
                      String username = userData['username'];
                      List<Map<String, dynamic>> quizResults = userData['quizResults'];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          '$username\'s Results:'.text.bold.make(),
                          Divider(),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: quizResults.length,
                            itemBuilder: (context, quizIndex) {
                              Map<String, dynamic> quizData = quizResults[quizIndex];
                              String quizId = quizData['quizId'];
                              int achievedPoints = quizData['achievedPoints'];
                              int totalPoints = quizData['totalPoints'];

                              return ListTile(
                                title: Text('Quiz: $quizId'),
                                subtitle: Text('Score: $achievedPoints/$totalPoints'),
                              );
                            },
                          ),
                        ],
                      ).p8();
                    },
                  ),
                ],
              ),
            ).p8(),
          ],
        ),
      ),
    );
  }
}