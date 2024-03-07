import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzity/auth/login.dart';
import 'package:quizzity/auth/verify_emali.dart';

import 'auth/forgot_password.dart';
import 'auth/register.dart';

void main() {
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
        GetPage(name: '/verify_email', page: () => const VerifyEmail()),
      ],
      home: Login(),
    );
  }
}
