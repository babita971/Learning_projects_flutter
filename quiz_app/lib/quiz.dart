import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/main.dart';
import 'package:quiz_app/questions_screen.dart';
import 'package:quiz_app/result.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  Widget? activeScreen;
  List<String> selectedAnswers = [];

  @override
  void initState() {
    activeScreen = StartPage(
      showQuestionsScreen: showQuestionsScreen,
    );
    //or simply use a variable and ?:
    super.initState();
  }

  void showQuestionsScreen() {
    setState(() {
      activeScreen = QuestionsPage(selectAnswer: selectAnswer);
    });
  }

  void restartQuestionScreen() {
    setState(() {
      selectedAnswers = [];
      activeScreen = QuestionsPage(selectAnswer: selectAnswer);
    });
  }

  void selectAnswer(String answer) {
    selectedAnswers.add(answer);
    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = ResultPage(
            selectedAnswers: selectedAnswers,
            restartQuestionScreen: restartQuestionScreen);
        selectedAnswers = [];
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    //Question why same initialization nto working from here
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Flutter Quiz',
            style: GoogleFonts.lato(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 113, 37, 194)),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 61, 24, 171),
                Color.fromARGB(255, 192, 7, 149)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: activeScreen,
        ),
      ),
    );
  }
}
