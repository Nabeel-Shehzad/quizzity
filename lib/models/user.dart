class Student{
  String firstName;
  String lastName;
  String email;
  String uid;

  Student({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.uid,
  });

  set setFirstName(String firstName) {
    this.firstName = firstName;
  }

  set setLastName(String lastName) {
    this.lastName = lastName;
  }

  set setEmail(String email) {
    this.email = email;
  }

  set setUid(String uid) {
    this.uid = uid;
  }

  String get getFirstName => firstName;

  String get getLastName => lastName;

  String get getEmail => email;

  String get getUid => uid;

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'uid': uid,
    };
  }
}