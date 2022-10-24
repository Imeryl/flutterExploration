import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final VoidCallback resetCallable;
  final int score;

  Result(this.score, this.resetCallable);

  String get resultPhrase {
    var resultText = 'Answers submitted. ';

    if (score <= 8) {
      resultText += 'Love you!';
    } else if (score <= 12) {
      resultText += 'Pretty good.';
    } else if (score <= 16) {
      resultText += 'Eh.';
    } else {
      resultText += 'Well this is awkward...';
    }

    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Text(
              resultPhrase,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            TextButton(
              onPressed: resetCallable,
              child: Text('Restart Quiz.'),
            )
          ],
        ),
      ),
    );
  }
}
