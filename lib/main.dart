import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/data/keys.dart';
import 'package:weather_app/presentation/screens/add_city_screen.dart';
import 'package:weather_app/presentation/screens/city_list_screen.dart';
import 'package:weather_app/presentation/screens/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/widgets/w_persistent_tab_view.dart';
import 'bloc/add_city/add_city_bloc.dart';
import 'bloc/city_list/city_list_bloc.dart';
import 'bloc/weather/weather_bloc.dart';

// Remember to include your own API keys for OpenWeatherMap (apiKey) and GoogleMaps Geocoding (googleMapsApiKey)
String weatherApiKey = "YOUR_API_KEY";
String googleMapsApiKey = "YOUR_API_KEY";

void main() {
  runApp(const WeatherApp());
}

final int currentHour = int.parse(DateTime.now().toString().substring(10, 13));
const int selectedIndex = 0;

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  PersistentTabController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(canvasColor: Colors.transparent),
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
            future: determinePosition(),
            builder: (context, snapshot) {
              final position = snapshot;
              final locationAvailableScreens = [
                BlocProvider<WeatherBloc>(
                  create: (context) => WeatherBloc(WeatherFactory(apiKey))
                    ..add(GetCurrentLocationWeather(position as Position)),
                  child: HomeScreen(
                    position: position,
                  ),
                ),
                BlocProvider<AddCityBloc>(
                  create: (context) =>
                      AddCityBloc(GeocodingService(apiKey: googleMapsApiKey)),
                  child: const AddCityScreen(),
                ),
                BlocProvider<CityListBloc>(
                  create: (context) => CityListBloc()..add(RefreshCityList()),
                  child: CityListScreen(),
                ),
              ];

              final locationNotAvailableScreens = [
                BlocProvider<WeatherBloc>(
                  create: (context) => WeatherBloc(WeatherFactory(apiKey)),
                  child: HomeScreen(
                    position: position,
                  ),
                ),
                BlocProvider<AddCityBloc>(
                  create: (context) =>
                      AddCityBloc(GeocodingService(apiKey: googleMapsApiKey)),
                  child: const AddCityScreen(),
                ),
                BlocProvider<CityListBloc>(
                  create: (context) => CityListBloc()..add(RefreshCityList()),
                  child: CityListScreen(),
                ),
              ];
              if (snapshot.hasData) {
                return WPersistentTabView(
                    controller: _controller, screens: locationAvailableScreens);
              } else {
                return WPersistentTabView(
                    controller: _controller,
                    screens: locationNotAvailableScreens);
              }
            }));
  }
}

//Function from Geolocator package
Future<Position> determinePosition() async {
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
