import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SleepChart extends StatelessWidget {
  const SleepChart({super.key});

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
    final hours = [7.5, 8.2, 6.8, 7.9, 8.0, 7.6, 8.1];
    final days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
    final maxY = (hours.reduce((a, b) => a > b ? a : b) + 1.0).ceilToDouble();

    return Container(
      height: 280,
      decoration: _chartBoxDecoration(),
      padding: const EdgeInsets.all(16),
      child: BarChart(
        BarChartData(
          minY: 0,
          maxY: maxY,
          alignment: BarChartAlignment.spaceAround,
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 32,
                getTitlesWidget: (value, _) {
                  final i = value.toInt();
                  if (i < 0 || i >= days.length) return const SizedBox.shrink();
                  return Text(days[i], style: const TextStyle(fontSize: 13));
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 36),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          barGroups: List.generate(
            hours.length,
            (i) => BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: hours[i],
                  color: const Color(0xffb03a57),
                  width: 20,
                  borderRadius: BorderRadius.circular(6),
                ),
              ],
            ),
          ),
        ),
        swapAnimationDuration: const Duration(milliseconds: 600),
      ),
    );
  }
}
