import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amountSpent;
  final double percentageOfSpending;

  ChartBar({
    required this.label,
    required this.amountSpent,
    required this.percentageOfSpending,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 20,
          child: FittedBox(
            child: Text('£${amountSpent.toStringAsFixed(2)}'),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
              FractionallySizedBox(
                heightFactor: percentageOfSpending,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(label),
      ],
    );
  }
}
