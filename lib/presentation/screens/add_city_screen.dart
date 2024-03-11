import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/data/data.dart';
import 'package:weather_app/presentation/styles/colors.dart';
import 'package:weather_app/presentation/widgets/w_text.dart';

class GeocodingService {
  final String apiKey;

  GeocodingService({required this.apiKey});

  Future<Map<String, dynamic>?> getCoordinates(String address) async {
    final endpoint = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=$apiKey');

    final response = await http.get(endpoint);

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      if (decoded['status'] == 'OK') {
        return decoded['results'][0]['geometry']['location'];
      } else {
        print(
            'Geocoding API request failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    }
    return null;
  }
}

class AddCityScreen extends StatefulWidget {
  const AddCityScreen({super.key});

  @override
  State<AddCityScreen> createState() => _AddCityScreenState();
}

class _AddCityScreenState extends State<AddCityScreen> {
  final TextEditingController _controller = TextEditingController();
  final GeocodingService geocodingService =
      GeocodingService(apiKey: googleMapsApiKey);

  void _getAndSaveCity() async {
    final address = _controller.text;
    final coordinates = await geocodingService.getCoordinates(address);
    print("Getting and saving coordinates");
    if (coordinates != null) {
      setState(() {
        print("Coordinates fetched successfully");
      });
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final data = jsonEncode(coordinates);
      await prefs.setString(address, data);
      print("Coordinates saved successfully");
    } else {
      setState(() {
        print("Failed to fetch coordinates");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 121, 159, 202),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const WText(
            text: "Add a city",
            size: 55,
            weight: FontWeight.w600,
          ),
          const WText(
            text: "Here you can add a city to monitor its weather",
            textAlign: TextAlign.center,
          ),
          const Gap(50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextField(
              controller: _controller,
              style: const TextStyle(
                  color: WColors.white,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.none),
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: WColors.white, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: WColors.lightBlue, width: 2.0),
                  ),
                  border: OutlineInputBorder(),
                  labelText: 'Enter City',
                  labelStyle: TextStyle(color: WColors.white)),
            ),
          ),
          const Gap(30),
          ElevatedButton(
            onPressed: () {
              _getAndSaveCity();
            },
            style: ElevatedButton.styleFrom(backgroundColor: WColors.lightBlue),
            child: const WText(text: 'Add a city'),
          ),
          const Gap(50),
        ],
      ),
    );
  }
}
