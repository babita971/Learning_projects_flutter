class Question {
  bool questionAnswer;
  String questionText;

  // Question({
  // Preferred way
  //   required this.questionAnswer,
  //   required this.questionText,
  // });

  Question(
    this.questionText,
    this.questionAnswer,
  );

  // Question(String q, bool a){
  //   //Added late to force Dart's type checking to occur at run time
  //   questionText = q;
  //   questionAnswer = a;
  // }

  //Below syntax is not correct.
  // Question({String q, bool a}) {
  //   questionText = q;
  //   questionAnswer = a;
  // }
}
