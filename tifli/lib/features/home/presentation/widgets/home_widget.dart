import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Welcome to Tifli!',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
