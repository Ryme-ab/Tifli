import 'package:flutter/material.dart';
import 'package:tifli/widgets/calendar.dart';
import 'package:tifli/features/trackers/presentation/widgets/tracker_button.dart';
import 'package:tifli/features/trackers/presentation/screens/sleep_tracker_screen.dart'; // ✅ Import your sleep page
import 'package:tifli/features/trackers/presentation/screens/growth_tracker_screen.dart'; // ✅ Import your growth page

class FoodPage extends StatefulWidget {
  const FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FAF5),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: const Text(
          'Add Trackers',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
          const Padding(
            padding: EdgeInsets.only(right: 12),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/parent_placeholder.jpg'),
            ),
          ),
        ],
      ),

      // --- Body ---
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Tracker Buttons Row ---
              TrackerButtonsRow(currentPage: 'food'),
              const SizedBox(height: 20),

              SmallWeekCalendar(),
              const SizedBox(height: 20),

              // --- Tracker Container ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7FBF8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    FeedingTrackerSection(),
                    SizedBox(height: 20),
                    Text(
                      'Notes',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    SizedBox(height: 6),
                    _NotesField(),
                    SizedBox(height: 30),
                    _SaveButton(),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

// --- TrackerButtonsRow widget ---
class TrackerButtonsRow extends StatelessWidget {
  final String currentPage;
  const TrackerButtonsRow({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // --- Food Tracker (Yellow - stays active here) ---
        TrackerButton(
          icon: Icons.water_drop,
          borderColor: Colors.amber,
          activeColor: Colors.amber,
          isActive: currentPage == 'food',
          onTap: () {}, // stays on the same page
        ),
        const SizedBox(width: 20),

        // --- Sleep Tracker (Blue - navigate to SleepPage) ---
        TrackerButton(
          icon: Icons.nightlight_round,
          borderColor: Colors.blue,
          activeColor: Colors.blue,
          isActive: currentPage == 'sleep',
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SleepPage()),
            );
          },
        ),
        const SizedBox(width: 20),

        // --- Growth Tracker (Green - navigate to GrowthPage) ---
        TrackerButton(
          icon: Icons.child_care,
          borderColor: Colors.green,
          activeColor: Colors.green,
          isActive: currentPage == 'growth',
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const GrowthPage()),
            );
          },
        ),
      ],
    );
  }
}

// --- Feeding Tracker Section ---
class FeedingTrackerSection extends StatefulWidget {
  const FeedingTrackerSection({super.key});

  @override
  State<FeedingTrackerSection> createState() => _FeedingTrackerSectionState();
}

class _FeedingTrackerSectionState extends State<FeedingTrackerSection> {
  String selectedFeeding = "Breast Milk";
  int quantity = 14;
  TimeOfDay selectedTime = const TimeOfDay(hour: 8, minute: 30);

  final List<String> feedingOptions = [
    "Breast Milk",
    "Formula",
    "Solid Food",
    "Juice",
  ];

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFA41639),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedTime) {
      setState(() => selectedTime = picked);
    }
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Feeding Name",
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButton<String>(
            value: selectedFeeding,
            isExpanded: true,
            underline: const SizedBox(),
            items: feedingOptions
                .map(
                  (option) => DropdownMenuItem(
                    value: option,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.local_drink,
                          color: Colors.black54,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(option),
                      ],
                    ),
                  ),
                )
                .toList(),
            onChanged: (val) => setState(() => selectedFeeding = val!),
          ),
        ),
        const SizedBox(height: 20),

        // Quantity and Time Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Quantity",
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            Text("Time", style: TextStyle(fontSize: 14, color: Colors.black54)),
          ],
        ),
        const SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Quantity Counter
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF9ECEE),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove, color: Color(0xFFA41639)),
                    onPressed: () {
                      setState(() {
                        if (quantity > 0) quantity--;
                      });
                    },
                  ),
                  Text(
                    '$quantity',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, color: Color(0xFFA41639)),
                    onPressed: () {
                      setState(() => quantity++);
                    },
                  ),
                ],
              ),
            ),

            // Time Picker
            GestureDetector(
              onTap: _pickTime,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9ECEE),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  _formatTime(selectedTime),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// --- Notes Field ---
class _NotesField extends StatelessWidget {
  const _NotesField();

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 3,
      decoration: InputDecoration(
        hintText: 'Add any notes...',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        isDense: true,
        contentPadding: const EdgeInsets.all(10),
      ),
    );
  }
}

// --- Save Button ---
class _SaveButton extends StatelessWidget {
  const _SaveButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.fastfood, color: Colors.white),
        label: const Text(
          'Save Food Tracker',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFA41639),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
