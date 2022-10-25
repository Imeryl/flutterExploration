import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart({required this.recentTransactions});

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0;
      for (final transaction in recentTransactions) {
        if (DateFormat.yMd().format(transaction.date) ==
            DateFormat.yMd().format(weekDay)) {
          totalSum += transaction.amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay),
        'amount': totalSum,
      };
    });
  }

  double get recentTransactionsTotal {
    return recentTransactions.fold<double>(
      0.0,
      (sum, transaction) => sum + transaction.amount,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: groupedTransactionValues.map((data) {
          return ChartBar(
            amountSpent: data['amount'] as double,
            percentageOfSpending: recentTransactionsTotal == 0.0
                ? 0.0
                : (data['amount'] as double) / recentTransactionsTotal,
            label: data['day'] as String,
          );
        }).toList(),
      ),
    );
  }
}
