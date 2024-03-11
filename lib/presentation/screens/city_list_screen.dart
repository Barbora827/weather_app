import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/presentation/screens/city_view_screen.dart';
import 'package:weather_app/presentation/styles/colors.dart';
import 'package:weather_app/presentation/widgets/w_text.dart';

import '../../data/models/city.dart';

class CityListScreen extends StatefulWidget {
  const CityListScreen({super.key});

  @override
  State<CityListScreen> createState() => _CityListScreenState();
}

class _CityListScreenState extends State<CityListScreen> {
  List<City> cities = [];

  @override
  void initState() {
    super.initState();
    _retrieveSavedCities();
  }

  Future<void> _retrieveSavedCities() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    final List<City> tempCities = [];
    for (final key in keys) {
      final data = prefs.getString(key);
      if (data != null) {
        final decodedData = jsonDecode(data);
        tempCities.add(City(
          name: key,
          latitude: decodedData['lat'].toString(),
          longitude: decodedData['lng'].toString(),
        ));
      }
    }
    setState(() {
      cities = tempCities;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: const Color.fromARGB(255, 67, 63, 93),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Gap(40),
            const WText(
              text: "My Cities",
              size: 55,
              weight: FontWeight.w600,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: cities.length,
                itemBuilder: (context, index) {
                  final city = cities[index];
                  return Card(
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: WText(
                        text: city.name,
                        color: WColors.white,
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CityViewScreen(
                                  cityName: city.name,
                                ),
                              ));
                        },
                        child: const Icon(
                          Icons.keyboard_arrow_right_outlined,
                          size: 40,
                          color: WColors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ]),
    );
  }
}
