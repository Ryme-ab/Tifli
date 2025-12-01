import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // built-in-ish, included in Flutter SDK; if missing remove and format manually
import 'package:tifli/features/schedules/presentation/screens/appointment_month_screen.dart';
import 'package:tifli/features/schedules/presentation/screens/appointment_week_screen.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  final PageController _pageController = PageController();
  int currentIndex = 0; // 0=Month 1=Week

  DateTime selectedDate = DateTime.now();

  // Example in-memory appointments keyed by date string (yyyy-MM-dd)
  Map<String, List<Map<String, String>>> appointments = {
    // today
    DateFormat('yyyy-MM-dd').format(DateTime.now()): [
      {"time": "08:30", "title": "Consultation"},
    ],
  };

  void _goToPage(int i) {
    setState(() => currentIndex = i);
    _pageController.animateToPage(
      i,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  List<DateTime> _weekFor(DateTime base) {
    // return 7 days representing the week containing base (Sun..Sat)
    final sunday = base.subtract(Duration(days: base.weekday % 7));
    return List.generate(7, (i) => sunday.add(Duration(days: i)));
  }

  List<Map<String, String>> _appointmentsForDate(DateTime d) {
    final key = DateFormat('yyyy-MM-dd').format(d);
    return appointments[key] ?? [];
  }

  void _addDummyAppointment(DateTime d) {
    final key = DateFormat('yyyy-MM-dd').format(d);
    final list = appointments.putIfAbsent(key, () => []);
    list.add({"time": "${8 + list.length}:00", "title": "New Event"});
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f4f8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Appointments',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Toggle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(child: _toggleButton("Month", 0)),
                  const SizedBox(width: 10),
                  Expanded(child: _toggleButton("Week", 1)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  MonthAppointmentsView(
                    selectedDate: selectedDate,
                    appointments: appointments,
                    onDayTap: (d) => setState(() => selectedDate = d),
                    onAdd: (d) {
                      setState(() {
                        appointments.putIfAbsent(
                          DateFormat('yyyy-MM-dd').format(d),
                          () => [],
                        );
                        appointments[DateFormat('yyyy-MM-dd').format(d)]!.add({
                          "time": "3:00 PM",
                          "title": "New Appointment",
                        });
                      });
                    },
                  ),

                  WeekAppointmentsView(
                    weekDays: _weekFor(selectedDate),
                    selected: selectedDate,
                    onDaySelected: (d) => setState(() => selectedDate = d),
                    appointmentsForDate: _appointmentsForDate,
                    onAdd: (d) => _addDummyAppointment(d),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _toggleButton(String label, int index) {
    final isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => _goToPage(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xffb03a57) : Colors.transparent,
          border: Border.all(color: const Color(0xffb03a57)),
          borderRadius: BorderRadius.circular(25),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xffb03a57),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
