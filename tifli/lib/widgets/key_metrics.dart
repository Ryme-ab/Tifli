import 'package:flutter/material.dart';

class KeyMetrics extends StatelessWidget {
  const KeyMetrics({super.key});

  @override
  Widget build(BuildContext context) {
    final metrics = [
      {
        "label": "Avg Sleep",
        "value": "7.8h",
        "icon": Icons.bedtime,
        "color": const Color(0xffffebee),
      },
      {
        "label": "Avg Feeding",
        "value": "6x/day",
        "icon": Icons.local_drink,
        "color": const Color(0xfffff9c4),
      },
      {
        "label": "Avg Height",
        "value": "65cm",
        "icon": Icons.height,
        "color": const Color(0xffe1bee7),
      },
      {
        "label": "Avg Temp",
        "value": "36.8°C",
        "icon": Icons.thermostat,
        "color": const Color(0xffffccbc),
      },
    ];

    return Wrap(
      spacing: 17,
      runSpacing: 12,
      children: metrics.map((m) {
        return Container(
          width: 160,
          height: 114,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.15),
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: m["color"] as Color,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(6),
                child: Icon(
                  m["icon"] as IconData,
                  color: const Color(0xffb03a57),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                m["label"] as String,
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                m["value"] as String,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xffb03a57),
                  fontSize: 18,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
