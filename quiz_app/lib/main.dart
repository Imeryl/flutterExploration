import 'package:flutter/material.dart';

import 'answer.dart';
import 'question.dart';

void main() => runApp(QuizApp());

class QuizApp extends StatefulWidget {
  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  var _questionIndex = 0;

  void _answerQuestion() {
    setState(() => _questionIndex++);
  }

  @override
  Widget build(BuildContext context) {
    var questions = [
      {
        'questionText': 'What\'s your favourite colour?',
        'answers': [
          'Black',
          'Red',
          'Purple',
          'Orange',
        ],
      },
      {
        'questionText': 'What\'s your favourite animal?',
        'answers': [
          'Snake',
          'Rabbit',
          'Lion',
          'Elephant',
        ],
      },
      {
        'questionText': 'What\'s your favourite anime?',
        'answers': [
          'Death Note',
          'Code Geass',
          'Made in Abyss',
          'Birdie Wing',
        ],
      },
    ];

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Quiz'),
        ),
        body: Column(
          children: <Widget>[
            Question(
              questions[_questionIndex]['questionText'] as String,
            ),
            ...(questions[_questionIndex]['answers'] as List<String>)
                .map((answer) {
              return Answer(_answerQuestion, answer);
            }).toList()
          ],
        ),
      ),
    );
  }
}
