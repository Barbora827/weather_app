import 'package:flutter/material.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/presentation/styles/colors.dart';

class WNavbar extends StatelessWidget {
  const WNavbar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  final int selectedIndex;
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
              color: Colors.black54,
              spreadRadius: 10,
              blurRadius: 20,
              offset: Offset(0, 2)),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(24),
          topLeft: Radius.circular(24),
        ),
        child: SizedBox(
          height: 75,
          child: BottomNavigationBar(
            iconSize: 30,
            unselectedFontSize: 14,
            selectedFontSize: 16,
            backgroundColor: WColors.white,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.cloud),
                label: 'Weather',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'Add city',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business),
                label: 'My Cities',
              ),
            ],
            currentIndex: selectedIndex,
            selectedItemColor: WColors.getTimeBasedColor(currentHour),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
