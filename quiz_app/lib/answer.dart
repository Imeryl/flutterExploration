import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final VoidCallback callback;

  Answer(this.callback);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        child: Text('Answer 1'),
        onPressed: callback,
      ),
    );
  }
}
