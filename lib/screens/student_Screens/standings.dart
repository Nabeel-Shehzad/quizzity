import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class Standings extends StatefulWidget {
  const Standings({Key? key});

  @override
  State<Standings> createState() => _StandingsState();
}

class _StandingsState extends State<Standings> {
  CollectionReference standings =
  FirebaseFirestore.instance.collection('results');
  FirebaseAuth auth = FirebaseAuth.instance;
  List<Map<String, dynamic>> quizResults = [];

  void getData() {
    FirebaseFirestore.instance
        .collection('results')
        .doc(auth.currentUser!.uid)
        .collection('results')
        .get()
        .then((QuerySnapshot querySnapshot) {
      setState(() {
        quizResults = querySnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
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
              child: Column(
                children: [
                  'Standings'.text.xl4.bold.white.makeCentered().p16(),
                  const SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.7,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        'Standings'.text.xl4.bold.makeCentered().p16(),
                        const SizedBox(height: 20),
                        Expanded(
                          child: ListView.builder(
                            itemCount: quizResults.length,
                            itemBuilder: (context, index) {
                              final result = quizResults[index];
                              return ListTile(
                                title: Text('Quiz ID: ${result['quizId']}'),
                                subtitle: Text(
                                  'Achieved Points: ${result['achievedPoints']} | Total Points: ${result['totalPoints']}',
                                ),
                                leading: FutureBuilder<String>(
                                  future: getTitle(result['quizId']),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    }
                                    if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    }
                                    return Text(snapshot.data ?? '');
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> getTitle(String quizId) async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('questions')
        .doc(quizId)
        .get();

    if (documentSnapshot.exists) {
      Map<String, dynamic>? data = documentSnapshot.data() as Map<String, dynamic>?;

      if (data != null) {
        return data['title'] ?? '';
      }
    }
    return '';
  }


}
