// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:quizzler/quizBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());
QuizBrain quizBrain = QuizBrain();

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Quizzler'),
          backgroundColor: Colors.grey[900],
        ),
        backgroundColor: Colors.grey[900],
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  int correctAnswersByUser = 0;
  int totalQuizQuestions = quizBrain.fetchTotalNoOfQuiestions();

  void checkForCorrectAnswer(bool answerByUser) {
    bool correctAnswer = quizBrain.getCorrectAnswer();

    setState(() {
      //Check if quiz is finished
      if (quizBrain.isQuizFinished()) {
        //Show alert and reset values.
        Alert(
          context: context,
          title: "Quiz is Finished!",
          desc:
              "You scored $correctAnswersByUser out of $totalQuizQuestions questions.",
          buttons: [
            DialogButton(
              // ignore: sort_child_properties_last
              child: Text(
                "Restart Quiz",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => { Navigator.of(context, rootNavigator: true).pop()},
              color: Colors.green,
            )
          ],
        ).show();
        // Alert(
        //   context: context,
        //   title: 'Finished!',
        //   desc: 'You\'ve reached the end of the quiz.',
        // ).show();

        quizBrain.resetQuizBank();
        correctAnswersByUser = 0;
        scoreKeeper = [];
      } else {
        if (correctAnswer == true) {
          correctAnswersByUser++;
          scoreKeeper.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        } else {
          scoreKeeper.add(
            Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }
        //Go to next question
        quizBrain.goToNextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 6,
          child: Center(
            child: Text(
              quizBrain
                  .getQuestionText(), //'This is where the question text will go.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              onPressed: () {
                checkForCorrectAnswer(true);
              },
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              onPressed: () {
                //TODO: Lets do this later
                checkForCorrectAnswer(false);
              },
              child: Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
        // Row(
        //   children: scoreKeeper,
        // ),
        Wrap(
          spacing: 5.0,
          runSpacing: 5.0,
          direction: Axis.horizontal, // main axis (rows or columns)
          children: scoreKeeper,
        )
      ],
    );
  }
}
