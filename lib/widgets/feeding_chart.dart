import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class FeedingChart extends StatelessWidget {
  const FeedingChart({super.key});

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
    final feeds = [5.0, 6.0, 7.0, 6.0, 5.0, 6.0, 7.0];
    final days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
    final maxY = (feeds.reduce((a, b) => a > b ? a : b) + 1.0).ceilToDouble();

    return Container(
      height: 260,
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
                getTitlesWidget: (value, _) {
                  final i = value.toInt();
                  if (i < 0 || i >= days.length) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Text(days[i], style: const TextStyle(fontSize: 13)),
                  );
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
            feeds.length,
            (i) => BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: feeds[i],
                  color: Colors.amber.shade700,
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
