import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/places.dart';
import 'package:provider/provider.dart';

import '../screens/places_list_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Places(),
      child: MaterialApp(
          title: 'Great Places',
          theme: ThemeData(
            colorSchemeSeed: Colors.purple,
          ),
          home: PlacesListScreen()),
    );
  }
}
