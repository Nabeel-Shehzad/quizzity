import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:quizzity/screens/instructor_screens/courses.dart';
import 'package:quizzity/screens/instructor_screens/quizzes.dart';
import 'package:quizzity/screens/instructor_screens/reports.dart';

class InstructorHomeController extends GetxController {
  RxInt selectedIndex = 0.obs; // 0 for Courses, 1 for Quizzes
  Widget? currentWidget = Courses(); // Replace with your CourseWidget

  void changeTab(int index) {
    selectedIndex.value = index;
    switch (index) {
      case 0:
        currentWidget = Courses();
        break;
      case 1:
        currentWidget = Quizzes(); // Replace with your QuizWidget
        break;
      case 2:
        currentWidget = Reports(); // Replace with your ReportWidget
        break;
    }
    update(); // Notify GetX to rebuild dependent widgets
  }
}