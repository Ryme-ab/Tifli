import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tifli/widgets/appointmentcard.dart';
import 'package:tifli/features/schedules/presentation/screens/appointment_form_screen.dart';

class MonthAppointmentsView extends StatefulWidget {
  final DateTime selectedDate;
  final Map<String, List<Map<String, String>>> appointments;
  final ValueChanged<DateTime> onDayTap;
  final void Function(DateTime) onAdd;

  const MonthAppointmentsView({
    super.key,
    required this.selectedDate,
    required this.appointments,
    required this.onDayTap,
    required this.onAdd,
  });

  @override
  State<MonthAppointmentsView> createState() => _MonthAppointmentsViewState();
}

class _MonthAppointmentsViewState extends State<MonthAppointmentsView> {
  late DateTime _displayedMonth;

  @override
  void initState() {
    super.initState();
    _displayedMonth = DateTime(
      widget.selectedDate.year,
      widget.selectedDate.month,
    );
  }

  void _goToPreviousMonth() {
    setState(() {
      _displayedMonth = DateTime(
        _displayedMonth.year,
        _displayedMonth.month - 1,
      );
    });
  }

  void _goToNextMonth() {
    setState(() {
      _displayedMonth = DateTime(
        _displayedMonth.year,
        _displayedMonth.month + 1,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = DateUtils.getDaysInMonth(
      _displayedMonth.year,
      _displayedMonth.month,
    );

    final firstDayOfMonth = DateTime(
      _displayedMonth.year,
      _displayedMonth.month,
      1,
    );
    final weekdayOffset = firstDayOfMonth.weekday % 7; // 0 = Sunday
    final totalGridDays = daysInMonth + weekdayOffset;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      children: [
        // month header
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: _goToPreviousMonth,
                icon: const Icon(Icons.chevron_left),
              ),
              Text(
                DateFormat('MMMM yyyy').format(_displayedMonth),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: _goToNextMonth,
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Day labels
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
              .map(
                (d) => Text(
                  d,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              )
              .toList(),
        ),

        // Calendar grid
        Container(
          decoration: BoxDecoration(
            color: const Color(0xfffff0f5),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(12),
          child: Wrap(
            spacing: 16,
            runSpacing: 10,
            children: List.generate(totalGridDays, (index) {
              if (index < weekdayOffset) {
                // Empty cells before the first day
                return const SizedBox(width: 40, height: 10);
              }

              final day = index - weekdayOffset + 1;
              final currentDate = DateTime(
                _displayedMonth.year,
                _displayedMonth.month,
                day,
              );

              final key = DateFormat('yyyy-MM-dd').format(currentDate);
              final hasAppointments =
                  (widget.appointments[key] ?? []).isNotEmpty;

              final isSelected =
                  DateFormat('yyyy-MM-dd').format(currentDate) ==
                  DateFormat('yyyy-MM-dd').format(widget.selectedDate);

              return GestureDetector(
                onTap: () => widget.onDayTap(currentDate),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xffb03a57)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        "$day",
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : Colors.grey.shade800,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      if (hasAppointments)
                        const Positioned(
                          bottom: 4,
                          child: Icon(
                            Icons.circle,
                            size: 6,
                            color: Colors.pinkAccent,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),

        const SizedBox(height: 18),

        // Appointments + Add button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${DateFormat('d MMM yyyy').format(widget.selectedDate)} Appointments",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            OutlinedButton.icon(
              onPressed: () async {
                final newLog = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AppointmentScreen(),
                  ),
                );

                if (newLog != null) {
                  widget.onAdd(widget.selectedDate);
                }
              },
              icon: const Icon(Icons.add, color: Color(0xffb03a57)),
              label: const Text(
                "Add",
                style: TextStyle(color: Color(0xffb03a57)),
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        // Appointment list
        ..._appointmentsListFor(widget.selectedDate, widget.appointments),
      ],
    );
  }

  List<Widget> _appointmentsListFor(
    DateTime date,
    Map<String, List<Map<String, String>>> appointments,
  ) {
    final key = DateFormat('yyyy-MM-dd').format(date);
    final list = appointments[key] ?? [];
    if (list.isEmpty) {
      return [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("No appointments"),
        ),
      ];
    }
    return list
        .map(
          (a) =>
              AppointmentCard(time: a['time'] ?? '', title: a['title'] ?? ''),
        )
        .toList();
  }
}
