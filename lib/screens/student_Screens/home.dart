import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../models/user.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseAuth auth = FirebaseAuth.instance;
  Student? student;
  Text username = Text('Welcome');
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  void getUserDetails() async {
    try {
      User? user = auth.currentUser;
      DocumentSnapshot documentSnapshot = await users.doc(user!.uid).get();
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      Student student = Student(
        firstName: data['firstName'],
        lastName: data['lastName'],
        email: data['email'],
        uid: data['uid'],
      );
      setState(() {
        student = student;
        username = Text('Hello, ${student.firstName} ${student.lastName}');
      });
    } catch (error) {
      Get.snackbar(
        'Error getting user details',
        error.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      rethrow;
    }
  }

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: username,
        backgroundColor: const Color(0xFFE18D5B),
        actions: [
          PopupMenuButton(
              onSelected: (value) {
                if (value == 0) {
                  Get.toNamed('/profile');
                } else if (value == 1) {
                  Get.toNamed('/standings');
                } else if (value == 2) {
                  auth.signOut();
                  Get.offAllNamed('/login');
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                    const PopupMenuItem(
                      child: Text('Profile'),
                      value: 0,
                    ),
                    const PopupMenuItem(
                      child: Text('Standings'),
                      value: 1,
                    ),
                    const PopupMenuItem(
                      child: Text('Logout'),
                      value: 2,
                    ),
                  ]),
        ],
      ),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  //show questions in list which are available from data
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('questions')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text('Loading');
                      }
                      return ListView(
                        shrinkWrap: true,
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;
                          return ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            titleTextStyle: TextStyle(
                              fontSize: 20,
                            ),
                            subtitleTextStyle: TextStyle(
                              fontSize: 15,
                            ),
                            leadingAndTrailingTextStyle: TextStyle(
                              fontSize: 20,
                            ),
                            title: Text(
                              'Course: ${data['courseName']} - Title: ${data['title']}',
                              style: TextStyle(
                                color: DateTime.now().isBefore(
                                        DateTime.parse(data['dueDate']))
                                    ? Colors.white // Color when enabled
                                    : Colors.red,
                              ),
                            ),
                            subtitle: Text(
                              'Due Date: ${data['dueDate']}',
                              style: TextStyle(
                                color: DateTime.now().isBefore(
                                        DateTime.parse(data['dueDate']))
                                    ? Colors.white // Color when enabled
                                    : Colors.red,
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Points: ${data['points']}',
                                  style: TextStyle(
                                    color: DateTime.now().isBefore(
                                            DateTime.parse(data['dueDate']))
                                        ? Colors.white // Color when enabled
                                        : Colors.red,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.join_full),
                                  color: DateTime.now().isBefore(
                                          DateTime.parse(data['dueDate']))
                                      ? Colors.green
                                      : Colors.red,
                                  onPressed: () {
                                    // Your onPressed logic here
                                  },
                                ),
                              ],
                            ),
                            enabled: DateTime.now()
                                    .isBefore(DateTime.parse(data['dueDate']))
                                ? true
                                : false,
                            onTap: () {
                              Get.offAndToNamed(
                                '/take_quiz',
                                arguments: {
                                  'quizId': document.id,
                                },
                              );
                            },
                          );
                        }).toList(),
                      );
                    },
                  ),
                ],
              ).p8(),
            ),
          ],
        ),
      ),
    );
  }
}
