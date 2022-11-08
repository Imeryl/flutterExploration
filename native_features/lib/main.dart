import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/places.dart';
import '../screens/add_place_screen.dart';
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
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (_) => AddPlaceScreen(),
        },
      ),
    );
  }
}
