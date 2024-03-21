import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _groupValue = 'Instructor';

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
              child: Column(children: [
                Container(
                  width: double.infinity,
                  child: Image.asset(
                    'assets/logo.png',
                    height: 200,
                    width: 200,
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      'LOGIN'.text.xl5.bold.white.make(),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ).p8(),
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ).p8(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.toNamed('/forgot_password');
                            },
                            child: 'Forgot Password?'.text.white.xl.make(),
                          ),
                        ],
                      ).p8(),
                      //radio buttons instructo login or student login
                      Row(
                        children: [
                          Radio(
                            value: 'Instructor',
                            onChanged: (value) {
                              setState(() {
                                _groupValue = value!;
                              });
                            },
                            groupValue: _groupValue,
                          ),
                          'Instructor'.text.white.xl.make(),
                          Radio(
                            value: 'Student',
                            groupValue: _groupValue,
                            onChanged: (value) {
                              setState(() {
                                _groupValue = value!;
                              });
                            },
                          ),
                          'Student'.text.white.xl.make(),
                        ],
                      ).p8(),
                      //add button at center width 200 and background color 0xFF0F1B47
                      ElevatedButton(
                        onPressed: () {
                          Get.offAllNamed('/home');
                        },
                        child: 'Login'.text.xl.color(Colors.white).make(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0F1B47),
                          minimumSize: const Size(250, 50),
                        ),
                      ).centered(),
                      const SizedBox(height: 5),
                      //dont have an account? register
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          'Don\'t have an account?'.text.xl.make(),
                          TextButton(
                            onPressed: () {
                              Get.offAllNamed('/register');
                            },
                            child: 'Register'.text.xl.color(Colors.black).make(),
                          ),
                        ],
                      ).p8(),
                    ],
                  ).p24(),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
