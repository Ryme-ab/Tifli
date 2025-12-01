import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TemperatureChart extends StatelessWidget {
  const TemperatureChart({super.key});

  BoxDecoration _chartBoxDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.15),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    final temps = [36.8, 36.9, 37.0, 36.7, 36.8, 37.1, 36.9];
    final days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

    // Expanded Y range for clarity
    const minY = 36.0;
    const maxY = 38.0;

    return Container(
      height: 280,
      decoration: _chartBoxDecoration(),
      padding: const EdgeInsets.all(16),
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: (temps.length - 1).toDouble(),
          minY: minY,
          maxY: maxY,
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 32,
                getTitlesWidget: (value, _) {
                  final i = value.toInt().clamp(0, days.length - 1);
                  return Text(days[i], style: const TextStyle(fontSize: 13));
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 36),
            ),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(
                temps.length,
                (i) => FlSpot(i.toDouble(), temps[i]),
              ),
              color: Colors.redAccent,
              dotData: FlDotData(show: true),
              barWidth: 3,
              isCurved: true,
            ),
          ],
        ),
        duration: const Duration(milliseconds: 600),
      ),
    );
  }
}
