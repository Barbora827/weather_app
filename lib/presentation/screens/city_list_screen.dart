import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:weather_app/presentation/styles/colors.dart';
import 'package:weather_app/presentation/widgets/w_text.dart';

import '../../data/models/city.dart';

class CityListScreen extends StatelessWidget {
  const CityListScreen({super.key});

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
              size: 60,
              weight: FontWeight.w600,
            ),
            FutureBuilder<List<City>>(
                future: fetchCities(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final cities = snapshot.data!;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: cities.length,
                        itemBuilder: (context, index) {
                          final city = cities[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            color: Colors.transparent,
                            child: ListTile(
                              title: WText(text: city.name),
                              trailing: const Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: WColors.white,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                })
          ]),
    );
  }
}
