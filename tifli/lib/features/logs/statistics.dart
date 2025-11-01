import 'package:flutter/material.dart';
import 'package:tifli/widgets/key_metrics.dart';
import 'package:tifli/widgets/growth_chart.dart';
import 'package:tifli/widgets/sleep_chart.dart';
import 'package:tifli/widgets/feeding_chart.dart';
import 'package:tifli/widgets/temperature_chart.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f4f8),
      appBar: AppBar(
        backgroundColor: const Color(0xffb03a57),
        title: const Text("Statistics"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text(
            "Key Metrics",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          KeyMetrics(),
          SizedBox(height: 28),
          Text(
            "Growth Trend",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          GrowthChart(),
          SizedBox(height: 28),
          Text(
            "Daily Sleep Duration",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          SleepChart(),
          SizedBox(height: 28),
          Text(
            "Feeding Frequency",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          FeedingChart(),
          SizedBox(height: 28),
          Text(
            "Body Temperature",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          TemperatureChart(),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
