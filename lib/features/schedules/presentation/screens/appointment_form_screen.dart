import 'package:flutter/material.dart';
import 'package:tifli/widgets/appbar.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final TextEditingController doctorNameController = TextEditingController();
  final TextEditingController doctorLocationController =
      TextEditingController();
  final TextEditingController doctorSpecialityController =
      TextEditingController();
  final TextEditingController notesController = TextEditingController();

  TimeOfDay? appointmentTime;
  DateTime? appointmentDate;
  TimeOfDay? reminderTime;
  DateTime? reminderDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: "Appointment Schedule"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Add An Appointment",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),

            _buildTextField("Doctor Name", doctorNameController),
            const SizedBox(height: 15),

            _buildTextField("Doctor Location", doctorLocationController),
            const SizedBox(height: 15),

            _buildTextField("Doctor Speciality", doctorSpecialityController),
            const SizedBox(height: 25),

            Row(
              children: [
                Expanded(
                  child: _buildTimePicker("Time", appointmentTime, (t) {
                    setState(() => appointmentTime = t);
                  }),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildDatePicker("Day", appointmentDate, (d) {
                    setState(() => appointmentDate = d);
                  }),
                ),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              "Set a remainder",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: _buildTimePicker("Time", reminderTime, (t) {
                    setState(() => reminderTime = t);
                  }),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildDatePicker("Day", reminderDate, (d) {
                    setState(() => reminderDate = d);
                  }),
                ),
              ],
            ),

            const SizedBox(height: 25),
            _buildNotesField(),
            const SizedBox(height: 30),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD9436B),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(color: Colors.black87, width: 0.5),
                  ),
                ),
                onPressed: () {},
                icon: const Icon(Icons.save_outlined, color: Colors.white),
                label: const Text(
                  "Save Appointment",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -----------------
  // Reusable Widgets
  // -----------------

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF7F4F9),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.black87, width: 0.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.black87, width: 0.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.black, width: 0.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimePicker(
    String label,
    TimeOfDay? selectedTime,
    Function(TimeOfDay) onTimePicked,
  ) {
    return GestureDetector(
      onTap: () async {
        final picked = await showTimePicker(
          context: context,
          initialTime: selectedTime ?? TimeOfDay.now(),
        );
        if (picked != null) onTimePicked(picked);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.pink[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black87, width: 0.5),
        ),
        alignment: Alignment.center,
        child: Text(
          selectedTime != null ? selectedTime.format(context) : label,
          style: const TextStyle(color: Colors.black87, fontSize: 14),
        ),
      ),
    );
  }

  Widget _buildDatePicker(
    String label,
    DateTime? selectedDate,
    Function(DateTime) onDatePicked,
  ) {
    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (picked != null) onDatePicked(picked);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.pink[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black87, width: 0.5),
        ),
        alignment: Alignment.center,
        child: Text(
          selectedDate != null
              ? "${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year}"
              : label,
          style: const TextStyle(color: Colors.black87, fontSize: 14),
        ),
      ),
    );
  }

  Widget _buildNotesField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Notes",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: notesController,
          maxLines: 3,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF7F4F9),
            hintText: "Add any notes here...",
            contentPadding: const EdgeInsets.all(15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
