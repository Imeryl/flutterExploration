import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int score;

  Result(this.score);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Answers submitted, you scored: ' + score.toString()),
      ),
    );
  }
}
