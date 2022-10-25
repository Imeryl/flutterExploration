import 'package:flutter/material.dart';

import 'new_transaction.dart';
import 'transaction_list.dart';
import '../models/transaction.dart';

class AppBody extends StatefulWidget {
  const AppBody({super.key});

  @override
  State<AppBody> createState() => _AppBodyState();
}

class _AppBodyState extends State<AppBody> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: '1',
      title: 'Shoes',
      amount: 35.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: '1',
      title: 'Take out',
      amount: 16.46,
      date: DateTime.now(),
    ),
  ];

  void _addTransaction(String title, double amount) {
    setState(() {
      _userTransactions.add(
        Transaction(
          id: DateTime.now().toString(),
          title: title,
          amount: amount,
          date: DateTime.now(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Card(
              child: Text('Chart'),
              elevation: 5,
            ),
            NewTransaction(_addTransaction),
            TransactionList(
              transactions: _userTransactions,
            )
          ],
        ),
      ),
    );
  }
}
