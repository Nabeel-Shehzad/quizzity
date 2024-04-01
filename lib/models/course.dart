class Course{
  String courseName;
  String courseCode;
  String courseDescription;
  int numberOfStudents;

  Course({
    required this.courseName,
    required this.courseCode,
    required this.courseDescription,
    required this.numberOfStudents,
  });


  get getCourseName => courseName;
  get getCourseCode => courseCode;
  get getCourseDescription => courseDescription;
  get getNumberOfStudents => numberOfStudents;

  set setCourseName(String courseName) => this.courseName = courseName;
  set setCourseCode(String courseCode) => this.courseCode = courseCode;
  set setCourseDescription(String courseDescription) => this.courseDescription = courseDescription;
  set setNumberOfStudents(int numberOfStudents) => this.numberOfStudents = numberOfStudents;

  Map<String, dynamic> toMap() {
    return {
      'courseName': courseName,
      'courseCode': courseCode,
      'courseDescription': courseDescription,
      'numberOfStudents': numberOfStudents,
    };
  }
}