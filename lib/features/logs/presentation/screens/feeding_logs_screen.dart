import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // built-in-ish, included in Flutter SDK; if missing remove and format manually
import 'package:fl_chart/fl_chart.dart';
import 'package:tifli/features/logs/presentation/screens/edit_feeding_log_screen.dart';

class FeedingLogsScreen extends StatefulWidget {
  const FeedingLogsScreen({super.key});

  @override
  State<FeedingLogsScreen> createState() => _FeedingLogsScreenState();
}

class _FeedingLogsScreenState extends State<FeedingLogsScreen> {
  List<Map<String, dynamic>> logs = [
    {
      "type": "Formula",
      "icon": Icons.local_drink,
      "time": "08:30 AM",
      "amount": "120ml",
      "color": const Color(0xfffff0f0),
    },
    {
      "type": "Solid",
      "icon": Icons.restaurant,
      "time": "12:30 PM",
      "amount": "40g",
      "color": const Color(0xfffff9e0),
    },
    {
      "type": "Breast Milk",
      "icon": Icons.local_hospital,
      "time": "16:00 PM",
      "amount": "90ml",
      "color": const Color(0xffffe5ec),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f4f8),
      appBar: AppBar(
        title: const Text(
          'Feeding Tracker',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // header row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Feeding Logs',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                CircleAvatar(
                  radius: 18,
                  backgroundImage: const AssetImage('assets/profile.jpg'),
                  backgroundColor: Colors.grey[200],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // logs (dismissible)
            ...logs.map((log) => _logCard(log)),

            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Daily Feeding Summary',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _miniBarChart(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xffb03a57),
        onPressed: _addDummy,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _logCard(Map<String, dynamic> log) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Dismissible(
        key: Key(log['type'] + log.hashCode.toString()),
        direction: DismissDirection.endToStart,
        background: Container(
          decoration: BoxDecoration(
            color: const Color(0xffb03a57),
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        onDismissed: (_) => setState(() => logs.remove(log)),
        child: Container(
          decoration: BoxDecoration(
            color: log['color'],
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(log['icon'], color: const Color(0xffb03a57)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      log['type'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      log['time'],
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
              Text(
                log['amount'],
                style: const TextStyle(
                  color: Colors.pinkAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xffb03a57),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Completed',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.grey),
                onPressed: () async {
                  // Open the edit form screen
                  final updatedLog = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditLogForm(
                        log: log, // pass the log data you want to edit
                      ),
                    ),
                  );

                  // When coming back from the form
                  if (updatedLog != null) {
                    setState(() {
                      final index = logs.indexOf(log);
                      logs[index] = updatedLog; // update the log in memory
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _miniBarChart() {
    final barData = [
      {"label": "Breast", "value": 4.0, "color": const Color(0xffffcdd2)},
      {"label": "Formula", "value": 2.5, "color": const Color(0xfffff9c4)},
      {"label": "Solid", "value": 1.5, "color": const Color(0xfffff0f0)},
    ];

    final double maxVal = barData
        .map((d) => d["value"] as double)
        .reduce((a, b) => a > b ? a : b);

    return SizedBox(
      height: 180,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) {
                  final int index = value.toInt();
                  if (index < 0 || index >= barData.length) {
                    return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      barData[index]["label"] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          barGroups: List.generate(barData.length, (index) {
            final entry = barData[index];
            final color = entry["color"] as Color;
            final double value = entry["value"] as double;
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: value,
                  color: color,
                  width: 30,
                  borderRadius: BorderRadius.circular(6),
                ),
              ],
            );
          }),
        ),
        swapAnimationDuration: const Duration(milliseconds: 800),
      ),
    );
  }

  void _addDummy() {
    setState(
      () => logs.insert(0, {
        "type": "New",
        "icon": Icons.fastfood,
        "time": DateFormat('hh:mm a').format(DateTime.now()),
        "amount": "50ml",
        "color": const Color(0xfffff0f5),
      }),
    );
  }
}
