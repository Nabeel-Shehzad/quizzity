import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzity/auth/login.dart';
import 'package:quizzity/screens/home.dart';
import 'package:quizzity/screens/instructor_screens/add_course.dart';
import 'package:quizzity/screens/instructor_screens/add_quiz.dart';
import 'package:quizzity/screens/instructor_screens/edit_course.dart';
import 'package:quizzity/screens/instructor_screens/instructor_home.dart';

import 'auth/forgot_password.dart';
import 'auth/register.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quizzity',
      getPages: [
        GetPage(name: '/login', page: () => const Login()),
        GetPage(name: '/register', page: () => const Register()),
        GetPage(name: '/forgot_password', page: () => const ForgotPassword()),
        GetPage(name: '/home', page: () => const Home()),
        GetPage(name: '/instructor_home', page: () => const InstructorHome()),
        GetPage(name: '/add_course', page: () => const AddCourse()),
        GetPage(name: '/edit_course', page: () => const EditCourse()),
        GetPage(name: '/add_quiz', page: () => const AddQuiz()),
      ],
      home: Login(),
    );
  }
}
