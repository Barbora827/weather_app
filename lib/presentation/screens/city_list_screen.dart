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
  int currentPage = 1;
  final int itemsPerPage = 10;
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _retrieveSavedCities();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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

  void _removeCity(City city) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(city.name);

    setState(() {
      cities.remove(city);
    });
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMoreCities();
    }
  }

  Future<void> _loadMoreCities() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      await Future.delayed(const Duration(seconds: 1));

      final List<City> moreCities = [];
      setState(() {
        cities.addAll(moreCities);
        currentPage++;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: const Color.fromARGB(255, 67, 63, 93),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
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
            const WText(
              text:
                  "Here is the list of your added cities. Click on the card to see the detailed view.",
              textAlign: TextAlign.center,
              size: 18,
              maxLines: 3,
            ),
            const Gap(10),
            const WText(
              text: "Double tap the bin icon to delete a city from the list",
              textAlign: TextAlign.center,
              size: 18,
              color: WColors.red,
            ),
            Gap(15),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: cities.length + (isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == cities.length) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
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
                      leading: GestureDetector(
                        onDoubleTap: () {
                          _removeCity(city);
                        },
                        child: const Icon(
                          Icons.delete,
                          size: 30,
                          color: WColors.red,
                        ),
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CityViewScreen(
                                cityName: city.name,
                              ),
                            ),
                          );
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
            Gap(30),
          ],
        ),
      ),
    );
  }
}
