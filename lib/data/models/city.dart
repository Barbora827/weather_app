class City {
  final String name;
  final String latitude;
  final String longitude;

  City({required this.name, required this.latitude, required this.longitude});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
        name: json['name'] ?? 'New York',
        latitude: json['latitude'] ?? "40.712776",
        longitude: json['longitude'] ?? "-74.005974");
  }
}
