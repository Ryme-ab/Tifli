import 'package:flutter/material.dart';
import 'package:tifli/features/schedules/presentation/screens/appointments_screen.dart';
import 'package:tifli/features/schedules/presentation/screens/medicine_schedule_screen.dart';
import 'package:tifli/features/schedules/presentation/screens/meal_planner_screen.dart';

class SchedMenuScreen extends StatelessWidget {
  const SchedMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f4f8),
      appBar: AppBar(
        title: const Text("Trackers"),
        centerTitle: true,
        backgroundColor: const Color(0xffb03a57),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 40,
            runSpacing: 30,
            children: [
              _buildTrackerButton(
                context,
                icon: Icons.bedtime,
                label: "Track Sleep",
                color: const Color(0xffffcdd2),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AppointmentsScreen(),
                    ),
                  );
                },
              ),
              _buildTrackerButton(
                context,
                icon: Icons.fitness_center,
                label: "Track Growth",
                color: const Color(0xfff8bbd0),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const MedicineScreen()),
                  );
                },
              ),
              _buildTrackerButton(
                context,
                icon: Icons.local_drink,
                label: "Track Feeding",
                color: const Color(0xfffff9c4),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MealPlannerScreenV2(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrackerButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10),
              child: Icon(icon, color: const Color(0xffb03a57), size: 30),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
