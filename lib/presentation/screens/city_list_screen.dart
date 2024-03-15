import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:weather_app/bloc/city_list/city_list_bloc.dart';
import 'package:weather_app/presentation/screens/city_view_screen.dart';
import 'package:weather_app/presentation/styles/colors.dart';
import 'package:weather_app/presentation/widgets/w_text.dart';
import '../../data/models/city.dart';
import '../widgets/w_button.dart';

class CityListScreen extends StatelessWidget {
  List<City> cities = [];
  CityListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CityListBloc()..add(GetCities()),
      child: BlocBuilder<CityListBloc, CityListState>(
        builder: (context, state) {
          if (state is CityListSuccess) {
            cities = state.cities;
            return RefreshIndicator(
              onRefresh: () async {
                context.read<CityListBloc>().add(RefreshCityList());
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: WColors.darkPurple,
                child: cities.isNotEmpty
                    ? _buildCityListWidget()
                    : _buildEmptyListWidget(),
              ),
            );
          } else if (state is CityListLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: WText(
                text: "Error fetching data",
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildCityListWidget() {
    return BlocBuilder<CityListBloc, CityListState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(50),
              const WText(
                text: "My Cities",
                size: 55,
                weight: FontWeight.w600,
              ),
              const Gap(20),
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
              const Gap(10),
              const WText(
                text: "Pull down on the list to refresh it",
                textAlign: TextAlign.center,
                size: 18,
                color: WColors.white,
              ),
              const Gap(15),
              Expanded(
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: cities.length,
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
                            context.read<CityListBloc>().add(RemoveCity(city));
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
              const Gap(30),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyListWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: BlocBuilder<CityListBloc, CityListState>(
        builder: (context, state) {
          if (state is CityListSuccess) {
            return Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: WColors.darkPurple,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Gap(50),
                  const WText(
                    text: "My Cities",
                    size: 55,
                    weight: FontWeight.w600,
                  ),
                  const Gap(20),
                  const WText(
                    text:
                        "Here is the list of your added cities. Click on the card to see the detailed view.",
                    textAlign: TextAlign.center,
                    size: 18,
                    maxLines: 3,
                  ),
                  const Gap(10),
                  const WText(
                    text:
                        "Double tap the bin icon to delete a city from the list",
                    textAlign: TextAlign.center,
                    size: 18,
                    color: WColors.red,
                  ),
                  const Gap(100),
                  const WText(
                    text:
                        "No cities added yet! Go into the + tab and add a city!",
                    textAlign: TextAlign.center,
                    size: 25,
                    color: WColors.white,
                    maxLines: 3,
                  ),
                  const Gap(100),
                  WButton(
                    onTap: () {
                      context.read<CityListBloc>().add(RefreshCityList());
                    },
                    text: "Refresh",
                    textColor: WColors.white,
                    btnColor: WColors.lightPurple,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 15),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
