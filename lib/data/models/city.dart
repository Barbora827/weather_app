import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class City {
  final String name;
  final String latitude;
  final String longitude;

  City({required this.name, required this.latitude, required this.longitude});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
        name: json['name'] ?? '',
        latitude: json['latitude'] ?? "40.712776",
        longitude: json['longitude'] ?? "-74.005974");
  }
}

Future<List<City>> fetchCities() async {
  final jsonString = await rootBundle.loadString('assets/json/cities.json');
  final jsonList = json.decode(jsonString) as List<dynamic>;
  return jsonList.map((e) => City.fromJson(e)).toList();
}
