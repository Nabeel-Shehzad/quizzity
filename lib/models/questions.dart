class Questions{
  String question;
  String optionA;
  String optionB;
  String optionC;
  String optionD;
  String correctAnswer;

  Questions({
    required this.question,
    required this.optionA,
    required this.optionB,
    required this.optionC,
    required this.optionD,
    required this.correctAnswer,
  });

  get getQuestion => question;
  get getOptionA => optionA;
  get getOptionB => optionB;
  get getOptionC => optionC;
  get getOptionD => optionD;
  get getCorrectAnswer => correctAnswer;

  set setQuestion(String question) => this.question = question;
  set setOptionA(String optionA) => this.optionA = optionA;
  set setOptionB(String optionB) => this.optionB = optionB;
  set setOptionC(String optionC) => this.optionC = optionC;
  set setOptionD(String optionD) => this.optionD = optionD;

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'optionA': optionA,
      'optionB': optionB,
      'optionC': optionC,
      'optionD': optionD,
      'correctAnswer': correctAnswer,
    };
  }

  factory Questions.fromJson(Map<String, dynamic> json) {
    return Questions(
      question: json['question'],
      optionA: json['optionA'],
      optionB: json['optionB'],
      optionC: json['optionC'],
      optionD: json['optionD'],
      correctAnswer: json['correctAnswer'],
    );
  }

}