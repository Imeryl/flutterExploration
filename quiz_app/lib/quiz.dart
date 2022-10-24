import 'package:flutter/material.dart';

import 'answer.dart';
import 'question.dart';

class Quiz extends StatelessWidget {
  final VoidCallback answerCallback;
  final List<Map<String, Object>> questions;
  final int questionIndex;

  Quiz({
    required this.questions,
    required this.answerCallback,
    required this.questionIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Question(
            questions[questionIndex]['questionText'] as String,
          ),
          ...(questions[questionIndex]['answers'] as List<String>)
              .map((answer) {
            return Answer(answerCallback, answer);
          }).toList()
        ],
      ),
    );
  }
}
