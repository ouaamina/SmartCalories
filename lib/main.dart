import 'package:flutter/material.dart';
import 'package:smart_calories/screens/camera.dart';
import 'package:smart_calories/screens/filter_selection.dart';
import 'package:smart_calories/screens/home_screen.dart';
import 'package:smart_calories/screens/introduce_meal_screen.dart';
import 'package:smart_calories/screens/snap_meal_screen.dart';

void main() {
  runApp(SmartCaloriesApp());
}


class SmartCaloriesApp extends StatefulWidget {
  @override
  State<SmartCaloriesApp> createState() => _SmartCaloriesState();
}

class _SmartCaloriesState extends State<SmartCaloriesApp> {
  int _selectedIndex = 3; // Default to Home

  late final List<Widget> _screens = [
    IntroduceMealScreen(),
    SnapMealScreen(),
    NutritionHomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CaloriesAI',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: NutritionHomePage(),

        // bottomNavigationBar: BottomNavigationBar(
        //   currentIndex: _selectedIndex,
        //   onTap: (index) => setState(() => _selectedIndex = index),
        //   items: const [
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.edit_note),
        //       label: 'Text',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.camera_alt),
        //       label: 'Snap',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.home),
        //       label: 'Home',
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
