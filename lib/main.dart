import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/data/data.dart';
import 'package:weather_app/presentation/screens/add_city_screen.dart';
import 'package:weather_app/presentation/screens/city_list_screen.dart';
import 'package:weather_app/presentation/screens/weather_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/styles/colors.dart';
import 'package:weather_app/presentation/widgets/w_navbar.dart';
import 'package:weather_app/presentation/widgets/w_text.dart';

import 'bloc/add_city/add_city_bloc.dart';
import 'bloc/city_list/city_list_bloc.dart';
import 'bloc/weather/weather_bloc.dart';

void main() {
  runApp(const WeatherApp());
}

// final int currentHour = 21;
final int currentHour = int.parse(DateTime.now().toString().substring(10, 13));

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  int _selectedIndex = 0;

  late List<Widget> _screens;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(canvasColor: Colors.transparent),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          extendBody: true,
          // Need to request permission for position outside of bloc
          body: FutureBuilder(
            future: _determinePosition(),
            builder: (context, snap) {
              if (snap.hasData) {
                _screens = [
                  BlocProvider<WeatherBloc>(
                    create: (context) => WeatherBloc(WeatherFactory(apiKey))
                      ..add(GetCurrentLocationWeather(snap.data as Position)),
                    child: const WeatherScreen(),
                  ),
                  BlocProvider<AddCityBloc>(
                    create: (context) => AddCityBloc(),
                    child: const AddCityScreen(),
                  ),
                  BlocProvider<CityListBloc>(
                    create: (context) => CityListBloc(),
                    child: const CityListScreen(),
                  ),
                ];
                return _screens[_selectedIndex];
              } else {
                return const Scaffold(
                    body: Center(
                  child: WText(
                    text: "Loading...",
                    size: 50,
                    color: WColors.black,
                  ),
                ));
              }
            },
          ),
          bottomNavigationBar:
              WNavbar(selectedIndex: _selectedIndex, onTap: _onItemTapped)),
    );
  }
}

//Function from Geolocator package
Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}
