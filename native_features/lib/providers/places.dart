import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/helpers/db_helper.dart';

import '../models/place.dart';

class Places with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get places {
    return [..._places];
  }

  void addPlace(String name, File image) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: image,
      location: null,
      name: name,
    );
    _places.add(newPlace);
    notifyListeners();
    DBHelper.insert('places', {
      'id': newPlace.id,
      'image': newPlace.image.path,
      'name': newPlace.name,
    });
  }

  Future<void> fetchPlaces() async {
    final data = await DBHelper.get('places');
    _places = data
        .map(
          (item) => Place(
            id: item['id'],
            image: File(item['image']),
            location: null,
            name: item['name'],
          ),
        )
        .toList();
    notifyListeners();
  }
}
