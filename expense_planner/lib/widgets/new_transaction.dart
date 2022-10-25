import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransactionCallback;

  NewTransaction(this.addTransactionCallback);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();
  final _titleController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    final double enteredAmount = double.parse(_amountController.text);
    final String enteredTitle = _titleController.text;

    if (enteredAmount <= 0 || enteredTitle.isEmpty || _selectedDate == null)
      return;

    widget.addTransactionCallback(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) return;

      _selectedDate = value;
      setState(() => _dateController.text = DateFormat.yMd().format(value));
    });
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
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    label: Text('Title'),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller: _amountController,
                  decoration: InputDecoration(
                    label: Text('Amount'),
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Container(
                height: 70,
                child: TextField(
                  controller: _dateController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    label: Text('Date'),
                  ),
                  readOnly: true,
                  onTap: _showDatePicker,
                ),
              ),
              ElevatedButton(
                onPressed: _submitData,
                child: Text(
                  'Add Transaction',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
