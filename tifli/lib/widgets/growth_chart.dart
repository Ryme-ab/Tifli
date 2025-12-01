import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GrowthChart extends StatelessWidget {
  const GrowthChart({super.key});

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
    final heightData = [60.0, 61.5, 63.0, 64.5, 65.5, 66.2, 67.0];
    final weightData = [6.2, 6.4, 6.6, 6.9, 7.1, 7.3, 7.5];
    final labels = List.generate(heightData.length, (i) => "M${i + 1}");

    final allValues = [...heightData, ...weightData];
    final minY = (allValues.reduce((a, b) => a < b ? a : b) - 3).floorToDouble();
    final maxY = (allValues.reduce((a, b) => a > b ? a : b) + 3).ceilToDouble();

    return Container(
      height: 320,
      decoration: _chartBoxDecoration(),
      padding: const EdgeInsets.all(16),
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: (labels.length - 1).toDouble(),
          minY: minY,
          maxY: maxY,
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: true, drawVerticalLine: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 36,
                getTitlesWidget: (value, _) {
                  final i = value.toInt().clamp(0, labels.length - 1);
                  return Text(labels[i], style: const TextStyle(fontSize: 13));
                },
              ),
            ),
            leftTitles:
                AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 40)),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(
                heightData.length,
                (i) => FlSpot(i.toDouble(), heightData[i]),
              ),
              color: const Color(0xffb03a57),
              isCurved: true,
              dotData: FlDotData(show: true),
              barWidth: 3,
            ),
            LineChartBarData(
              spots: List.generate(
                weightData.length,
                (i) => FlSpot(i.toDouble(), weightData[i]),
              ),
              color: Colors.amber.shade700,
              isCurved: true,
              dotData: FlDotData(show: true),
              barWidth: 3,
            ),
          ],
        ),
        duration: const Duration(milliseconds: 600),
      ),
    );
  }
}
