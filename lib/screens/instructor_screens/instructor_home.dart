import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:quizzity/controllers/instructor_home_controller.dart';
import 'package:quizzity/widgets/topbar.dart';
import 'package:velocity_x/velocity_x.dart';

class InstructorHome extends StatefulWidget {
  const InstructorHome({super.key});

  @override
  State<InstructorHome> createState() => _InstructorHomeState();
}

class _InstructorHomeState extends State<InstructorHome> {
  final InstructorHomeController _instructorHomeController =
      Get.put(InstructorHomeController());
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
                  Topbar(),
                  const SizedBox(height: 20),
                  GetBuilder<InstructorHomeController>(
                    builder: (controller) {
                      if (controller.currentWidget != null) {
                        return controller.currentWidget!;
                      } else {
                        // Handle the case where currentWidget is null
                        return Container(); // Or any other fallback widget
                      }
                    },
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
