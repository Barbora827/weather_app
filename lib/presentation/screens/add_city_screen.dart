import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/bloc/add_city/add_city_bloc.dart';
import 'package:weather_app/data/keys.dart';
import 'package:weather_app/presentation/styles/colors.dart';
import 'package:weather_app/presentation/widgets/w_button.dart';
import 'package:weather_app/presentation/widgets/w_no_internet_display.dart';
import 'package:weather_app/presentation/widgets/w_text.dart';

class AddCityScreen extends StatelessWidget {
  const AddCityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AddCityBloc(GeocodingService(apiKey: googleMapsApiKey))
            ..add(GetAddCityScreen()),
      child: Scaffold(
        body: AddCityUI(),
      ),
    );
  }
}

class AddCityUI extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  AddCityUI({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCityBloc, AddCityState>(
      listener: (context, state) {
        if (state is CitySaved) {
          // Show Snackbar for CitySaved
          final snackBar = SnackBar(
            backgroundColor: WColors.green,
            content: SizedBox(
              height: 40,
              child: WText(
                text: "City ${_controller.text} saved",
                textAlign: TextAlign.center,
              ),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          FocusManager.instance.primaryFocus?.unfocus();
          _controller.clear();
        } else if (state is CitySaveFailed) {
          // Show Snackbar for CitySaveFailed
          const snackBar = SnackBar(
            backgroundColor: WColors.red,
            content: SizedBox(
              height: 60,
              child: WText(
                text: "Error saving city. Are you sure you typed it correctly?",
                textAlign: TextAlign.center,
              ),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          FocusManager.instance.primaryFocus?.unfocus();
          _controller.clear();
        }
      },
      builder: (context, state) {
        // If user is connected to the internet
        if (state is! AddCityNoInternet) {
          return Container(
            color: WColors.lightBlue,
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
                              color: (state is CitySaveFailed)
                                  ? WColors.red
                                  : WColors.white,
                              width: 2.0),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: WColors.white, width: 2.0),
                        ),
                        border: const OutlineInputBorder(),
                        labelText: 'Enter City',
                        labelStyle: const TextStyle(color: WColors.white)),
                  ),
                ),
                const Gap(30),
                WButton(
                  onTap: () {
                    context.read<AddCityBloc>().add(SaveCity(_controller.text));
                  },
                  text: "Add a city",
                  textColor: WColors.white,
                  btnColor: WColors.blue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                ),
                const Gap(70),
              ],
            ),
          );
        } else {
          // If offline
          return Container(
              color: WColors.lightBlue,
              child: WNoInternetDisplay(
                  cache: false,
                  onTap: () {
                    context.read<AddCityBloc>().add(GetAddCityScreen());
                  }));
        }
      },
    );
  }
}

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
