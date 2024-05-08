import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/result_widget.dart';

class ResultPage extends StatefulWidget {
  const ResultPage(
      {required this.restartQuestionScreen,
      required this.selectedAnswers,
      super.key});
  final List<String> selectedAnswers;
  final void Function() restartQuestionScreen;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  List<ResultData> resultDataList = [];
  int totalCorrectAnswers = 0;

  List<ResultData> get gettterResultDataList {
    for (var i = 0; i < questions.length; i++) {
      if (questions[i].answers.first == widget.selectedAnswers[i]) {
        totalCorrectAnswers++;
      }
      resultDataList.add(
        ResultData(
            questionIndex: i + 1,
            question: questions[i].text,
            correctAnswer: questions[i].answers.first,
            selectedAnswer: widget.selectedAnswers[i]),
      );
      // OR use where
      // totalCorrectAnswers = resultDataList.where((element) {
      //   return element.correctAnswer == element.selectedAnswer;
      // }).length;
    }
    return resultDataList;
  }

  @override
  Widget build(BuildContext context) {
    gettterResultDataList;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            //DO MORE HERE
            "You have answered $totalCorrectAnswers out of ${questions.length} questions correctly",
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 400,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...resultDataList.map(
                    (data) => ResultWidget(
                      questionIndex: data.questionIndex,
                      correctAnswer: data.correctAnswer,
                      selectedAnswer: data.selectedAnswer,
                      question: data.question,
                    ),
                  ),
                ],
              ),
            ),
            // ListView.builder(
            //     itemCount: resultDataList.length,
            //     shrinkWrap: true,
            //     scrollDirection: Axis.vertical,
            //     itemBuilder: (context, index) {
            //       return Padding(
            //         padding: const EdgeInsets.only(bottom: 8.0),
            // child: ResultWidget(
            //   questionIndex: resultDataList[index].questionIndex,
            //   correctAnswer: resultDataList[index].correctAnswer,
            //   selectedAnswer: resultDataList[index].selectedAnswer,
            //   question: resultDataList[index].question,
            // ),
            //       );
            //     }),
          ),
          const SizedBox(
            height: 20,
          ),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            icon: const Icon(Icons.refresh),
            onPressed: () {
              widget.restartQuestionScreen();
              // Navigator.of(context).pushAndRemoveUntil(
              //     MaterialPageRoute(builder: (context) => const QuizPage()),
              //     (Route<dynamic> route) => false);
            },
            label: const Text('Restart Quiz'),
          ),
        ],
      ),
    );
  }
}

class ResultData {
  ResultData({
    required this.questionIndex,
    required this.question,
    required this.correctAnswer,
    required this.selectedAnswer,
  });

  final int questionIndex;
  final String question;
  final String correctAnswer;
  final String selectedAnswer;
}
