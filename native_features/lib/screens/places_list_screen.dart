import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/places.dart';
import 'add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName),
            icon: Icon(Icons.add),
          ),
        ],
        title: Text('Your places'),
      ),
      body: Consumer<Places>(
        child: Center(
          child: Text('No places'),
        ),
        builder: (context, places, child) => places.places.length <= 0
            ? child as Widget
            : ListView.builder(
                itemBuilder: (context, i) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(places.places[i].image),
                  ),
                  title: Text(places.places[i].name),
                ),
                itemCount: places.places.length,
              ),
      ),
    );
  }
}
