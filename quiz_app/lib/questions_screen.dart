import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/data/questions.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({required this.selectAnswer, super.key});
  final void Function(String answer) selectAnswer;

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  int quizIndex = 0;
  int correctAnswers = 0;

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[quizIndex];
    return Scaffold(
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                currentQuestion.text,
                style: GoogleFonts.lato(
                    color: const Color.fromARGB(255, 217, 185, 251),
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
              const SizedBox(
                height: 20,
              ),
              //Using spread operator
              ...currentQuestion.getShuffledList.map((item) => AnswerButton(
                  answer: item,
                  onpressed: () {
                    widget.selectAnswer(item);
                    setState(() {
                      quizIndex++;
                    });
                  })),
              // ListView.builder(
              //   shrinkWrap: true,
              //   scrollDirection: Axis.vertical,
              //   itemCount: 4,
              //   itemBuilder: (context, index) {
              //     return AnswerButton(
              //         answer: currentQuestion.answers[index],
              //         onpressed: goToNextQuestion);
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnswerButton extends StatelessWidget {
  const AnswerButton(
      {required this.answer, required this.onpressed, super.key});

  final String answer;
  final void Function() onpressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color.fromARGB(255, 33, 1, 91),
          ),
          onPressed: onpressed,
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0, bottom: 5),
            child: Text(
              answer,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          )),
    );
  }
}
