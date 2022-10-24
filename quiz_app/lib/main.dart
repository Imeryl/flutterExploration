import 'package:flutter/material.dart';

import 'quiz.dart';
import 'result.dart';

void main() => runApp(QuizApp());

class QuizApp extends StatefulWidget {
  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  var _totalScore = 0;
  var _questionIndex = 0;
  final _questions = [
    {
      'questionText': 'What\'s your favourite colour?',
      'answers': [
        {
          'text': 'Black',
          'score': 2,
        },
        {
          'text': 'Red',
          'score': 4,
        },
        {
          'text': 'Purple',
          'score': 1,
        },
        {
          'text': 'Orange',
          'score': 7,
        },
      ],
    },
    {
      'questionText': 'What\'s your favourite animal?',
      'answers': [
        {
          'text': 'Snake',
          'score': 1,
        },
        {
          'text': 'Rabbit',
          'score': 8,
        },
        {
          'text': 'Lion',
          'score': 10,
        },
        {
          'text': 'Elephant',
          'score': 5,
        },
      ],
    },
    {
      'questionText': 'What\'s your favourite anime?',
      'answers': [
        {
          'text': 'Death Note',
          'score': 7,
        },
        {
          'text': 'Code Geass',
          'score': 5,
        },
        {
          'text': 'Made in Abyss',
          'score': 3,
        },
        {
          'text': 'Birdie Wing',
          'score': 1,
        },
      ],
    },
  ];

  void _answerQuestion(int score) {
    _totalScore += score;

    setState(() {
      _questionIndex++;
    });
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
            : Result(_totalScore),
      ),
    );
  }
}
