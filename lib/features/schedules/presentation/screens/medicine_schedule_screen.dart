import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MedicineScreen extends StatefulWidget {
  const MedicineScreen({super.key});

  @override
  State<MedicineScreen> createState() => _MedicineScreenState();
}

class _MedicineScreenState extends State<MedicineScreen> {
  DateTime selectedDate = DateTime.now();

  // in-memory medicine data with image path
  List<Map<String, dynamic>> morningMedicines = [
    {"name": "Omega 3", "image": "assets/omega.png", "taken": false},
    {"name": "Vitamin D", "image": "assets/vitamin_d.png", "taken": true},
  ];

  List<Map<String, dynamic>> nightMedicines = [
    {"name": "Zinc", "image": "assets/zinc.png", "taken": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f4f8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Medicine Schedule',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: const AssetImage('assets/profile.jpg'),
              backgroundColor: Colors.grey[200],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildWeekSelector(),
            const SizedBox(height: 16),

            // Scrollable medicine lists
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  const Text(
                    "☀️ Morning",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...morningMedicines
                      .map((m) => _medicineCard(m, isMorning: true)),
                  const SizedBox(height: 16),
                  const Text(
                    "🌙 Night",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...nightMedicines
                      .map((m) => _medicineCard(m, isMorning: false)),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),

      // Floating Add Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xffb03a57),
        onPressed: _dummyAddMedicine,
        child: const Icon(Icons.add),
      ),
    );
  }

  // ✅ WEEK SELECTOR (simple functional calendar-like bar)
  Widget _buildWeekSelector() {
    final startOfWeek = selectedDate.subtract(
      Duration(days: selectedDate.weekday % 7),
    );
    final weekDays = List.generate(
      7,
      (i) => startOfWeek.add(Duration(days: i)),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text(
              "Week of ${DateFormat('d MMM').format(weekDays.first)}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: weekDays.map((d) {
                final isSelected =
                    DateFormat('yyyy-MM-dd').format(d) ==
                    DateFormat('yyyy-MM-dd').format(selectedDate);
                return GestureDetector(
                  onTap: () => setState(() => selectedDate = d),
                  child: Column(
                    children: [
                      Text(
                        DateFormat('E').format(d),
                        style: TextStyle(
                          color: isSelected
                              ? Colors.black
                              : Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        width: 40,
                        height: 60,
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
                            color: isSelected
                                ? Colors.white
                                : Colors.grey.shade800,
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
          ],
        ),
      ),
    );
  }

  // ✅ Medicine card builder (image, checkbox, swipe-to-delete)
  Widget _medicineCard(
    Map<String, dynamic> medicine, {
    required bool isMorning,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Dismissible(
        key: Key(medicine['name'] + medicine.hashCode.toString()),
        direction: DismissDirection.endToStart,
        background: Container(
          decoration: BoxDecoration(
            color: const Color(0xffb03a57),
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        onDismissed: (_) {
          setState(() {
            if (isMorning) {
              morningMedicines.remove(medicine);
            } else {
              nightMedicines.remove(medicine);
            }
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: isMorning
                ? const Color(0xffdde1eb)
                : const Color(0xfff7f1d1),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // image
              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: (medicine['image'] != null)
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          medicine['image'],
                          fit: BoxFit.contain,
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      medicine['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "1 capsule after breakfast",
                      style: TextStyle(color: Colors.pinkAccent),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    medicine['taken'] = !(medicine['taken'] as bool);
                  });
                },
                child: Icon(
                  (medicine['taken'] as bool)
                      ? Icons.check_box
                      : Icons.check_box_outline_blank,
                  color: (medicine['taken'] as bool)
                      ? Colors.pinkAccent
                      : Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // dummy add button (for demonstration)
  void _dummyAddMedicine() {
    setState(() {
      morningMedicines.insert(0, {
        "name": "New Med ${DateTime.now().second}",
        "image": "assets/omega.png",
        "taken": false,
      });
    });
  }
}
