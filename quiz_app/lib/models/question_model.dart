class QuizQuestion {
  const QuizQuestion({required this.text, required this.answers});
  final String text;
  final List<String> answers;

//Note that below is a getter, not a simple funstion, hence no ()
  List<String> get getShuffledList {
    final List<String> shuffledList = List.of(answers);
    shuffledList.shuffle();
    return shuffledList;
  }
}

// Map<int, dynamic> quizData = {
//   1: {
//     'question': '1 What is this?',
//     'answers': [1, 2, 3, 4]
//   },
//   2: {
//     'question': '2 What is this?',
//     'answers': [1, 2, 3, 4]
//   },
//   3: {
//     'question': '3 What is this?',
//     'answers': [1, 2, 3, 4]
//   },
//   4: {
//     'question': '4 What is this?',
//     'answers': [1, 2, 3, 4]
//   },
//   5: {
//     'question': '5 What is this?',
//     'answers': [1, 2, 3, 4]
//   },
//   6: {
//     'question': '6 What is this?',
//     'answers': [1, 2, 3, 4]
//   },
// };
