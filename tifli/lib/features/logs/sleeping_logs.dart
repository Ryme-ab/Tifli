import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SleepingLogsScreen extends StatefulWidget {
  const SleepingLogsScreen({super.key});

  @override
  State<SleepingLogsScreen> createState() => _SleepingLogsScreenState();
}

class _SleepingLogsScreenState extends State<SleepingLogsScreen> {
  Widget _buildQuickStatsRow() {
    final totalSleep = weeklyHours.reduce((a, b) => a + b);
    final todaySleep = weeklyHours[DateTime.now().weekday % 7];

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            title: "This Week",
            value: "${totalSleep.toStringAsFixed(1)} hrs",
            icon: Icons.calendar_month,
            color: const Color(0xffe1bee7),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            title: "Today",
            value: "${todaySleep.toStringAsFixed(1)} hrs",
            icon: Icons.nightlight_round,
            color: const Color(0xffffccbc),
          ),
        ),
      ],
    );
  }

  List<Map<String, dynamic>> sleepLogs = [
    {
      "date": "Oct 25, 2025",
      "duration": "7h 45m",
      "quality": "Good",
      "color": const Color(0xffe0f7fa),
    },
    {
      "date": "Oct 24, 2025",
      "duration": "5h 30m",
      "quality": "Poor",
      "color": const Color(0xffffebee),
    },
    {
      "date": "Oct 23, 2025",
      "duration": "6h 15m",
      "quality": "Fair",
      "color": const Color(0xfffff9c4),
    },
  ];

  final Map<String, double> qualityData = {"Good": 60, "Fair": 25, "Poor": 15};

  final List<double> weeklyHours = [7.5, 6, 8, 5.5, 7, 6.5, 7.2];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f4f8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sleeping Tracker",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Sleep Logs",
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

            // Pie Chart
            _buildPieChartSection(),
            const SizedBox(height: 24),

            // Quick Stats Cards — 🧩 moved here above log list
            _buildQuickStatsRow(),

            const SizedBox(height: 24),

            // Logs
            const Text(
              "Recent Sleep Logs",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            ...sleepLogs.map(_buildSleepCard).toList(),

            const SizedBox(height: 24),

            // Weekly Trend
            const Text(
              "Weekly Sleep Trend",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 12),
            _buildWeeklyBarChart(),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xffb03a57),
        onPressed: _addDummyLog,
        child: const Icon(Icons.add),
      ),
    );
  }

  // 🥧 Pie chart for sleep quality
  Widget _buildPieChartSection() {
    final total = qualityData.values.reduce((a, b) => a + b);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Text(
            "Sleep Quality Distribution",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 180,
            child: PieChart(
              PieChartData(
                sections: qualityData.entries.map((entry) {
                  final color = switch (entry.key) {
                    "Good" => const Color(0xffb2dfdb),
                    "Fair" => const Color(0xfffff9c4),
                    "Poor" => const Color(0xffffccbc),
                    _ => Colors.grey,
                  };
                  final percentage = (entry.value / total) * 100;
                  return PieChartSectionData(
                    color: color,
                    value: entry.value,
                    title: "${percentage.toStringAsFixed(1)}%",
                    radius: 40,
                    titleStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  );
                }).toList(),
                centerSpaceRadius: 50,
                sectionsSpace: 2,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: qualityData.keys.map((key) {
              final color = switch (key) {
                "Good" => const Color(0xffb2dfdb),
                "Fair" => const Color(0xfffff9c4),
                "Poor" => const Color(0xffffccbc),
                _ => Colors.grey,
              };
              return Row(
                children: [
                  Container(width: 14, height: 14, color: color),
                  const SizedBox(width: 4),
                  Text(key),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // 💤 Sleep logs cards
  Widget _buildSleepCard(Map<String, dynamic> log) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Dismissible(
        key: Key(log['date'] + log.hashCode.toString()),
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
        onDismissed: (_) => setState(() => sleepLogs.remove(log)),
        child: Container(
          decoration: BoxDecoration(
            color: log['color'] ?? Colors.white,
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
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.nightlight_round,
                  color: Color(0xffb03a57),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      log['date'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "Duration: ${log['duration']}",
                      style: const TextStyle(color: Colors.pinkAccent),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xffb03a57),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  log['quality'],
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 📊 Weekly bar chart (sleep duration trend)
  // 📊 Weekly bar chart (sleep duration trend)
  Widget _buildWeeklyBarChart() {
    final days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
    final totalSleep = weeklyHours.reduce((a, b) => a + b);
    final todaySleep = weeklyHours[DateTime.now().weekday % 7];

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          height: 220,
          child: BarChart(
            BarChartData(
              gridData: FlGridData(show: false),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, _) {
                      final i = value.toInt();
                      if (i < 0 || i >= days.length)
                        return const SizedBox.shrink();
                      return Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          days[i],
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: true, reservedSize: 28),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              barGroups: List.generate(weeklyHours.length, (i) {
                return BarChartGroupData(
                  x: i,
                  barRods: [
                    BarChartRodData(
                      toY: weeklyHours[i],
                      color: const Color(0xffb03a57),
                      width: 16,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  // 🪶 small helper for quick stat cards
  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: const Color(0xffb03a57)),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: Color(0xffb03a57),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ➕ Add dummy data
  void _addDummyLog() {
    setState(() {
      sleepLogs.insert(0, {
        "date": DateFormat("MMM d, yyyy").format(DateTime.now()),
        "duration":
            "${5 + sleepLogs.length % 3}h ${20 + sleepLogs.length * 5}m",
        "quality": "Good",
        "color": const Color(0xffe0f7fa),
      });
    });
  }
}
