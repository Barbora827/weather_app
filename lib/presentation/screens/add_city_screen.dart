import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/bloc/add_city/add_city_bloc.dart';
import 'package:weather_app/data/data.dart';
import 'package:weather_app/presentation/styles/colors.dart';
import 'package:weather_app/presentation/widgets/w_button.dart';
import 'package:weather_app/presentation/widgets/w_no_internet_display.dart';
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
  bool _invalidAddress = false;
  bool _hasInternet = true;

  @override
  void initState() {
    super.initState();
    _checkInternetConnectivity();
  }

  Future<void> _checkInternetConnectivity() async {
    final ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    setState(() {
      _hasInternet = connectivityResult != ConnectivityResult.none;
    });
  }

  Future _getAndSaveCity() async {
    if (_hasInternet) {
      final address = _controller.text;

      // Reset _invalidAddress before checking the validity of the address
      setState(() {
        _invalidAddress = false;
      });

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
          _invalidAddress = true;
          print("Failed to fetch coordinates");
        });
      }
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCityBloc()..add(RefreshAddCityScreen()),
      child: Scaffold(
        body: BlocBuilder<AddCityBloc, AddCityState>(
          builder: (context, state) {
            if (state is AddCitySuccess) {
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
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: _invalidAddress
                                      ? WColors.red
                                      : WColors.white,
                                  width: 2.0),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: WColors.lightBlue, width: 2.0),
                            ),
                            border: const OutlineInputBorder(),
                            labelText: 'Enter City',
                            labelStyle: const TextStyle(color: WColors.white)),
                      ),
                    ),
                    const Gap(30),
                    WButton(
                      onTap: () async {
                        await _getAndSaveCity();
                        final snackBar = SnackBar(
                          backgroundColor:
                              _invalidAddress ? WColors.red : WColors.green,
                          content: SizedBox(
                            height: _invalidAddress ? 60 : 40,
                            child: WText(
                              text: _invalidAddress
                                  ? "Error saving city. Are you sure you typed it correctly?"
                                  : "City ${_controller.text} saved",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        FocusManager.instance.primaryFocus?.unfocus();
                        _controller.clear();
                      },
                      text: "Add a city",
                      textColor: WColors.white,
                      btnColor: const Color.fromARGB(255, 65, 91, 127),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 15),
                    ),
                    const Gap(70),
                  ],
                ),
              );
            } else {
              return Container(
                color: const Color.fromARGB(255, 121, 159, 202),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: WNoInternetDisplay(
                    cache: false,
                    onTap: () {
                      context.read<AddCityBloc>().add(RefreshAddCityScreen());
                    },
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
