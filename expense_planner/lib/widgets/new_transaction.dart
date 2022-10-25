import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransactionCallback;

  NewTransaction(this.addTransactionCallback);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final amountController = TextEditingController();

  final titleController = TextEditingController();

  void submitData() {
    final double enteredAmount = double.parse(amountController.text);
    final String enteredTitle = titleController.text;

    if (enteredAmount <= 0 || enteredTitle.isEmpty) return;

    widget.addTransactionCallback(
      enteredTitle,
      enteredAmount,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                cursorColor: Colors.purple,
                controller: titleController,
                decoration: InputDecoration(
                  label: Text('Title'),
                ),
                onSubmitted: (_) => submitData(),
              ),
              TextField(
                controller: amountController,
                decoration: InputDecoration(
                  label: Text('Amount'),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => submitData(),
              ),
              TextButton(
                onPressed: submitData,
                child: Text(
                  'Add Transaction',
                  style: TextStyle(color: Colors.purple),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
