import 'package:flutter/material.dart';
import 'screens/appointment_screen.dart';
import 'trackers/trackers.dart';
import '../calendar.dart';
import 'trackers/growth.dart';
import 'trackers/sleep.dart';
import 'trackers/food.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const FoodPage(),
    );
  }
}
