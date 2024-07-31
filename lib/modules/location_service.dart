// lib/modules/location_service.dart
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:geolocator/geolocator.dart';
import 'package:csv/csv.dart';

Future<List<Map<String, dynamic>>> findNearestPlaces(String city, String district) async {
  final input = await rootBundle.loadString('assets/tourist_attractions.csv');
  final fields = const CsvToListConverter().convert(input);

  final List<Map<String, dynamic>> data = fields.skip(1).map((field) {
    return {
      "city": field[0],
      "name": field[1],
      "latitude": field[2],
      "longitude": field[3],
      "address": field[4],
      "rating": field[5],
      "user_ratings_total": field[6]
    };
  }).toList();

  final cityDistrict = data.where((place) =>
  place['city'].toString().toLowerCase().trim() == city.toLowerCase().trim() &&
      place['address'].toString().toLowerCase().trim().contains(district.toLowerCase().trim()));

  if (cityDistrict.isEmpty) {
    return [];
  }

  final cityLat = cityDistrict.first['latitude'];
  final cityLng = cityDistrict.first['longitude'];

  data.forEach((place) {
    place['distance'] = Geolocator.distanceBetween(cityLat, cityLng, place['latitude'], place['longitude']);
  });

  data.sort((a, b) => a['distance'].compareTo(b['distance']));

  return data.take(5).toList();
}
