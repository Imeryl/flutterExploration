import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final amountController = TextEditingController();
  final titleController = TextEditingController();
  final Function addTransactionCallback;

  NewTransaction(this.addTransactionCallback);

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
                decoration: InputDecoration(
                  label: Text('Title'),
                ),
                controller: titleController,
              ),
              TextField(
                decoration: InputDecoration(
                  label: Text('Amount'),
                ),
                controller: amountController,
              ),
              TextButton(
                onPressed: () => addTransactionCallback(
                  titleController.text,
                  amountController.text,
                ),
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
