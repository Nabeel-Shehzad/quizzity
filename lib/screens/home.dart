import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../models/user.dart';

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
                  //Get.toNamed('/profile');
                } else {
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
                      child: Text('Logout'),
                      value: 1,
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
                  Container(
                    child: 'Toppers'.text.white.xl3.bold.make().p8(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
