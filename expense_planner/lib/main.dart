import 'package:flutter/material.dart';

import 'widgets/app_body.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: null,
            icon: Icon(Icons.add),
          ),
        ],
        backgroundColor: Colors.purple,
        title: Text('Flutter App'),
      ),
      body: AppBody(),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.purple,
        icon: Icon(Icons.add),
        label: Text('Add Transaction'),
        onPressed: null,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
