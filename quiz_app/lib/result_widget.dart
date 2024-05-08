import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultWidget extends StatelessWidget {
  const ResultWidget(
      {required this.correctAnswer,
      required this.questionIndex,
      required this.question,
      required this.selectedAnswer,
      super.key});

  final int questionIndex;
  final String question;
  final String selectedAnswer;
  final String correctAnswer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: selectedAnswer == correctAnswer
                // ? const Color.fromARGB(255, 26, 72, 208)
                // : const Color.fromARGB(255, 219, 5, 169),

                ? const Color.fromARGB(255, 150, 198, 241)
                : const Color.fromARGB(255, 249, 133, 241),
            child: Text(
              questionIndex.toString(),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  question,
                  style: GoogleFonts.lato(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Text(
                  selectedAnswer,
                  style: GoogleFonts.lato(
                      color: const Color.fromARGB(255, 202, 171, 252),
                      // Color.fromARGB(255, 179, 109, 191),
                      fontSize: 18),
                ),
                Text(
                  correctAnswer,
                  style: GoogleFonts.lato(
                      color: const Color.fromARGB(255, 181, 254, 246),
                      //Color.fromARGB(255, 84, 163, 177),
                      fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
