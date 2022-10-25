import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function removeCallback;

  TransactionList({required this.transactions, required this.removeCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text('No transactions added yet!'),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                  height: 200,
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            )
          : ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: FittedBox(
                          child: Text(
                            '£${transactions[index].amount.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      DateFormat.MMMd().format(transactions[index].date),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).colorScheme.error,
                      ),
                      onPressed: () => removeCallback(transactions[index].id),
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
