import 'package:flutter/material.dart';

import 'quiz.dart';
import 'result.dart';

void main() => runApp(QuizApp());

class QuizApp extends StatefulWidget {
  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  var _questionIndex = 0;
  final _questions = [
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

  void _answerQuestion() {
    setState(() => _questionIndex++);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Quiz'),
        ),
        body: _questionIndex < _questions.length
            ? Quiz(
                answerCallback: _answerQuestion,
                questionIndex: _questionIndex,
                questions: _questions,
              )
            : Result(),
      ),
    );
  }
}
