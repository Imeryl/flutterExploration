import 'package:flutter/material.dart';

class CateforiesScreen extends StatelessWidget {
  const CateforiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        maxCrossAxisExtent: 200,
        mainAxisSpacing: 20,
      ),
      children: <Widget>[],
    );
  }
}
