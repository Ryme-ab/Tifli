import 'package:flutter/material.dart';

void main() {
  runApp(const MedicineApp());
}

class MedicineApp extends StatelessWidget {
  const MedicineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medicine Schedule',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFC21E56),
        scaffoldBackgroundColor: const Color(0xFFF8F8FB),
        fontFamily: 'Poppins',
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        ),
      ),
      home: const MedicineSchedulePage(),
    );
  }
}

class MedicineSchedulePage extends StatefulWidget {
  const MedicineSchedulePage({super.key});

  @override
  State<MedicineSchedulePage> createState() => _MedicineSchedulePageState();
}

class _MedicineSchedulePageState extends State<MedicineSchedulePage> {
  final TextEditingController _medicineController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  int selectedDosage = 1;
  String durationType = 'Days';
  int durationValue = 14;
  String frequency = 'Everyday';
  String timeFrequency = 'Twice a day';
  int everyHours = 5;

  // Options for frequency to show in popup
  final List<String> _frequencyOptions = [
    'Everyday',
    'Every other day',
    'Weekdays',
    'Custom'
  ];

  final List<String> _timeFreqOptions = [
    'Twice a day',
    'Once a day',
    'Three times a day'
  ];

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFFC21E56);


    Widget filledDropdown<T>({
      required T value,
      required List<DropdownMenuItem<T>> items,
      required void Function(T?) onChanged,
      double? height,
      EdgeInsetsGeometry? padding,
    }) {
      return Container(
        height: height ?? 48,
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.06),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<T>(
            value: value,
            items: items,
            onChanged: onChanged,
            isExpanded: true,
            style: const TextStyle(color: Colors.black),
            icon: const Icon(Icons.keyboard_arrow_down),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.6,
        title: const Text(
          'Medicine Schedule',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: const [
          Icon(Icons.notifications_outlined, color: Colors.grey),
          SizedBox(width: 10),
          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuDCM45Jtq3D2rqHY4Ve7tQwkPXQzu1Qr5jyAf_GF9A57Y_t8Oal4aMD9XcQR2Df4og4dLoCsYZDRvDMKJo_wmg8edBIFElJ_HMBHK6y4ZvwnyVIZlcEr9El_dGV5o0oGU7wpqcTQJl6aa26Ep7yTl7gi1D3Z2QGetFWFg50-6LbcPvnJ2RcLuzX85HBiXiTZkE_GS082WtwWikBNqXQwg_5OdnpPHPNjoFPVLLQgA9pNW0l0AhSxmL5q2cBxFsy4v50rif9dv3D9JLM',
            ),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Text(
            "Add the medicine",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // Medicine Name
          TextField(
            controller: _medicineController,
            decoration: const InputDecoration(
              labelText: "Medicine Name",
            ),
          ),

          const SizedBox(height: 20),

          const Text("Dosage",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(10, (i) {
                int num = i + 1;
                bool selected = selectedDosage == num;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => setState(() => selectedDosage = num),
                    child: Container(
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selected ? primary : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.1),
                            blurRadius: 3,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        '$num',
                        style: TextStyle(
                          color: selected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),

          const SizedBox(height: 20),

          // Duration
          const Text("Duration",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: filledDropdown<String>(
                  value: durationType,
                  items: const [
                    DropdownMenuItem(value: "Days", child: Text("Days")),
                    DropdownMenuItem(value: "Weeks", child: Text("Weeks")),
                    DropdownMenuItem(value: "Months", child: Text("Months")),
                  ],
                  onChanged: (v) => setState(() => durationType = v!),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.pink.shade50,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove, color: primary),
                        onPressed: () =>
                            setState(() => durationValue = (durationValue > 1)
                                ? durationValue - 1
                                : durationValue),
                      ),
                      Text(
                        "$durationValue",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add, color: primary),
                        onPressed: () =>
                            setState(() => durationValue = durationValue + 1),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Frequency (styled as filled rounded dropdown to match design)
          const Text("Frequency",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
          const SizedBox(height: 8),
          filledDropdown<String>(
            value: frequency,
            items: _frequencyOptions
                .map((f) => DropdownMenuItem(value: f, child: Text(f)))
                .toList(),
            onChanged: (v) => setState(() => frequency = v!),
          ),

          const SizedBox(height: 20),

          // Appearance
          const Text("Appearance",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (var color in [
                Colors.yellow.shade100,
                Colors.purple.shade100,
                Colors.grey.shade300,
                Colors.pink.shade50,
                Colors.blue.shade100,
              ])
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                )
            ],
          ),

          const SizedBox(height: 20),

          // Time of taking medication
          const Text("Time of taking medication",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.pink.shade50,
                      borderRadius: BorderRadius.circular(12)),
                  child: const Text("8:30"),
                ),
              ),
              const SizedBox(width: 6),
              const CircleAvatar(
                radius: 14,
                backgroundColor: primary,
                child: Icon(Icons.check, color: Colors.white, size: 16),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: filledDropdown<String>(
                  value: timeFrequency,
                  items: _timeFreqOptions
                      .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                      .toList(),
                  onChanged: (v) => setState(() => timeFrequency = v!),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Every hours and start
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Every:"),
              DropdownButton<int>(
                value: everyHours,
                items: const [
                  DropdownMenuItem(value: 4, child: Text("4")),
                  DropdownMenuItem(value: 5, child: Text("5")),
                  DropdownMenuItem(value: 6, child: Text("6")),
                ],
                onChanged: (v) => setState(() => everyHours = v!),
              ),
              const Text("Hours  Start:"),
              Container(
                width: 70,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.pink.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text("8:30"),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Notes
          TextField(
            controller: _notesController,
            maxLines: 3,
            decoration: const InputDecoration(labelText: "Notes"),
          ),

          const SizedBox(height: 30),
        ],
      ),

      // Footer buttons
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.download),
                label: const Text("Save"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.cancel, color: primary),
                label: const Text(
                  "Cancel",
                  style: TextStyle(color: primary, fontWeight: FontWeight.w600),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: primary),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
