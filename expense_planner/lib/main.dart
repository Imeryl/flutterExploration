import 'package:flutter/material.dart';

import 'models/transaction.dart';
import 'widgets/new_transaction.dart';
import 'widgets/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        colorScheme: ColorScheme.light(
          primary: Colors.purple,
          secondary: Colors.blue,
          tertiary: Colors.orange,
        ),
      ),
      title: 'Flutter App',
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  void showAddTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return NewTransaction(_addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () => showAddTransaction(context),
            icon: Icon(Icons.add),
          ),
        ],
        backgroundColor: Colors.purple,
        title: Text('Flutter App'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Card(
                child: Text('Chart'),
                elevation: 5,
              ),
              TransactionList(
                transactions: _userTransactions,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        icon: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
        label: Text(
          'Add Transaction',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
        onPressed: () => showAddTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
