import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tifli/widgets/appointmentcard.dart';
import 'package:tifli/widgets/addlog.dart';

class WeekAppointmentsView extends StatelessWidget {
  final List<DateTime> weekDays;
  final DateTime selected;
  final ValueChanged<DateTime> onDaySelected;
  final List<Map<String, String>> Function(DateTime) appointmentsForDate;
  final void Function(DateTime) onAdd;

  const WeekAppointmentsView({
    super.key,
    required this.weekDays,
    required this.selected,
    required this.onDaySelected,
    required this.appointmentsForDate,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      children: [
        // header
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
                onPressed: () {},
                icon: const Icon(Icons.chevron_left),
              ),
              Text(
                "Week of ${DateFormat('d MMM').format(weekDays.first)}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // week bar
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: weekDays.map((d) {
              final isSelected =
                  DateFormat('yyyy-MM-dd').format(d) ==
                  DateFormat('yyyy-MM-dd').format(selected);
              return GestureDetector(
                onTap: () => onDaySelected(d),
                child: Column(
                  children: [
                    Text(
                      DateFormat('E').format(d),
                      style: TextStyle(
                        color: isSelected ? Colors.black : Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: 40,
                      height: 74,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xffb03a57)
                            : const Color(0xfffff0f5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "${d.day}",
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 18),

        // title row + add button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${DateFormat('d MMM yyyy').format(selected)} Appointments",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            OutlinedButton.icon(
              onPressed: () async {
                // Navigate to the AddLogForm
                final newLog = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddLogForm()),
                );

                // If the user filled the form and pressed "Add Log"
                if (newLog != null) {
                  // ✅ Tell parent widget to handle adding logic
                  onAdd(selected);
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

        // appointment cards
        ...appointmentsForDate(selected)
            .map(
              (a) => AppointmentCard(
                time: a['time'] ?? '',
                title: a['title'] ?? '',
              ),
            ),
      ],
    );
  }
}
