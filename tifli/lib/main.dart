import 'package:flutter/material.dart';
import 'package:tifli/features/navigation/app_router.dart';
import 'package:tifli/features/navigation/presentation/screens/main_tab_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tifli',
      theme: ThemeData(
        primaryColor: const Color(0xFFD93B63),
        scaffoldBackgroundColor: const Color(0xFFF7F8FC),
      ),
      initialRoute: '/',
      onGenerateRoute: AppRouter.generateRoute,
      home: const MainTabScreen(), 
    );
  }
}
