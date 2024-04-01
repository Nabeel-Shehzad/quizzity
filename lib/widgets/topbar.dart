import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';
import '../controllers/instructor_home_controller.dart';

class Topbar extends StatelessWidget {
  const Topbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InstructorHomeController controller = Get.find();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        'Quizzity'.text.white.xl3.make(),
        TextButton(
          onPressed: () {
            controller.changeTab(0);
          },
          child: 'Courses'.text.xl.white.make(),
        ),
        TextButton(
          onPressed: () {
            controller.changeTab(1);
          },
          child: 'Quizzes'.text.xl.white.make(),
        ),
        TextButton(
          onPressed: () {
            controller.changeTab(2);
          },
          child: 'Reports'.text.xl.white.make(),
        ),
      ],
    );
  }
}
