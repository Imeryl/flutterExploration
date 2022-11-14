import 'dart:io';

class PlaceLocation {
  final String address;
  final double latitude;
  final double longitude;

  PlaceLocation({
    required this.address,
    required this.latitude,
    required this.longitude,
  });
}

class Place {
  final String id;
  final File image;
  final PlaceLocation? location;
  final String name;

  Place({
    required this.id,
    required this.image,
    required this.location,
    required this.name,
  });
}
