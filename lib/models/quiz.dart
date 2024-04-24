import 'package:quizzity/models/questions.dart';

class Quiz{
  String quizId = '';
  String title;
  int points;
  String dueDate;
  String courseName = '';
  List<Questions> questions = [];

  Quiz({
    required this.title,
    required this.points,
    required this.dueDate,
  });

  get getTitle => title;
  get getPoints => points;
  get getDueDate => dueDate;
  get getQuestions => questions;
  get getQuizId => quizId;
  get getCourseName => courseName;

  set setQuizId(String quizId) => this.quizId = quizId;
  set setTitle(String title) => this.title = title;
  set setPoints(int points) => this.points = points;
  set setDueDate(String dueDate) => this.dueDate = dueDate;
  set setCourseName(String courseName) => this.courseName = courseName;
  set setQuestions(List<Questions> questions) => this.questions = questions;

  Map<String, dynamic> toMap() {
    return {
      'quizId': quizId,
      'title': title,
      'points': points,
      'dueDate': dueDate,
      'courseName': courseName,
      'questions': questions.map((question) => question.toMap()).toList(),
    };
  }
}