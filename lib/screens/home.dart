import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      'Hello World'.text.white.xl3.bold.make().p8(),
                      //circular profile icon
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: const CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage('assets/profile.png'),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    color: const Color(0xFFE18D5B),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 170, 0),
                          child: 'Points'.text.white.xl3.bold.make().p8(),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: '100'.text.white.xl3.bold.make().p8(),
                        ),
                      ],
                    ),
                  ).p8(),
                  SizedBox(height: 20,),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 170, 0),
                    child: 'Categories'.text.white.xl3.bold.make().p8(),
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
