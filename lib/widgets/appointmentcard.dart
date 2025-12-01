import 'package:flutter/material.dart';
import 'package:tifli/features/schedules/presentation/screens/appointment_details_screen.dart'; // import your target screen

class AppointmentCard extends StatelessWidget {
  final String time;
  final String title;

  const AppointmentCard({super.key, required this.time, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AppointmentDetailsScreen()),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: const Color(0xfffff0f5),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(color: Colors.pink.shade200, width: 2),
                ),
              ),
              child: Text(
                time,
                style: const TextStyle(
                  color: Color(0xffb03a57),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Details",
                    style: TextStyle(color: Colors.pinkAccent),
                  ),
                ],
              ),
            ),
            const Icon(Icons.track_changes, color: Color(0xffb03a57)),
          ],
        ),
      ),
    );
  }
}
