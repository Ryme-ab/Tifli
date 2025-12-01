import 'package:flutter/material.dart';

class BabyLogsReportsPage extends StatelessWidget {
  const BabyLogsReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF1C1C1E) : const Color(0xFFF9F6FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Logs & Reports",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          Icon(Icons.notifications_outlined,
              color: isDark ? Colors.white70 : Colors.black54),
          const SizedBox(width: 10),
          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(
              "https://lh3.googleusercontent.com/aida-public/AB6AXuCoTMZtpS6LgGWi2SnFhz7SX5I90Bmp-7mrJ_me7uj5uuFrQuCMowyZV-TP0xud8PrjCpuGMbmhV3E3ysYd-bT904RciiKRYyVnbXjK1I4Hy3TS61_Ma04i6BNBLmRKs_6XL_tQLOdW5vHcKp0Po6QCbRbWCvVGlYJonhZDelwQf7_RHO3nJcskJnWsjpbc8p_WMF9EA3UVWTaerYhkXCfaogQqb2pLDnsEA39R3hWzU48pWfZUD2qWeCX7LiL8sT9GuZr21sIjzTY",
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: Column(
        children: [
          // ---- Navigation Bar ----
          // ---- Navigation Bar removed (redundant) ----

          const SizedBox(height: 12),

          // ---- Top Buttons and Date ----
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF2C2C2E) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 6,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF56587),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                        onPressed: () {},
                        child: const Text("Daily"),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () {},
                        child: const Text("Weekly"),
                      ),
                    ],
                  ),
                  Row(
                    children: const [
                      Icon(Icons.calendar_month,
                          color: Color(0xFFF56587), size: 20),
                      SizedBox(width: 4),
                      Text("October 26, 2024",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // ---- Scrollable content ----
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // ---- Summary Cards ----
                  Row(
                    children: const [
                      Expanded(
                        child: InfoCard(
                          icon: Icons.local_drink,
                          title: "Feedings today",
                          value: "4",
                          subtitle: "sessions",
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: InfoCard(
                          icon: Icons.bedtime,
                          title: "Total Sleep",
                          value: "10h 30m",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const InfoCard(
                    icon: Icons.medication_liquid,
                    title: "Medication Doses",
                    value: "2",
                    subtitle: "doses",
                  ),
                  const SizedBox(height: 16),

                  // ---- Activity Logs ----
                  Container(
                    decoration: BoxDecoration(
                      color:
                          isDark ? const Color(0xFF2C2C2E) : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Activity Logs",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        LogTable(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),

      // ---- Bottom Buttons ----
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1C1C1E) : const Color(0xFFF9F6FA),
          border: Border(
            top: BorderSide(
              color: isDark
                  ? const Color(0xFF48484A)
                  : const Color(0xFFE5E5EA),
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.description),
              label: const Text("Generate Report"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF56587),
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(48),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {},
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              icon: const Icon(Icons.bar_chart, color: Color(0xFFF56587)),
              label: const Text(
                "View Statistics Dashboard",
                style: TextStyle(color: Color(0xFFF56587)),
              ),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final String label;
  final bool selected;

  const NavItem({super.key, required this.label, this.selected = false});

  @override
  Widget build(BuildContext context) {
    final color = selected
        ? Colors.black
        : Theme.of(context).textTheme.bodySmall!.color?.withValues(alpha: 0.6);
    return Column(
      children: [
        Text(label,
            style:
                TextStyle(fontSize: 13, fontWeight: selected ? FontWeight.w600 : FontWeight.w400, color: color)),
        if (selected)
          Container(
            margin: const EdgeInsets.only(top: 2),
            height: 3,
            width: 20,
            decoration: BoxDecoration(
              color: const Color(0xFFF56587),
              borderRadius: BorderRadius.circular(8),
            ),
          )
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String? subtitle;

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF3A3A3C) : const Color(0xFFFFF3F5),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFF56587).withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.local_drink, color: Color(0xFFF56587)),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 12,
                      color: isDark
                          ? Colors.grey[400]
                          : Colors.grey[700])),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(value,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black)),
                  if (subtitle != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Text(subtitle!,
                          style: TextStyle(
                              fontSize: 14,
                              color: isDark
                                  ? Colors.grey[400]
                                  : Colors.grey[700])),
                    )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class LogTable extends StatelessWidget {
  final logs = const [
    ["10:30 AM", "Feeding", "Completed\nBreast milk (right side)\n15 min"],
    ["09:00 AM", "Sleep", "1h 15m\nNap"],
    ["07:00 AM", "Medication", "Given\nVitamin D 0.5 ml"],
    ["06:30 AM", "Feeding", "Completed\nFormula - 120 ml"],
    ["12:00 AM", "Sleep", "7h 30m\nNight Sleep"],
    ["Yesterday\n09:00 PM", "Growth", "12 lbs 3 oz\nWeight check"],
    ["Today\n03:00 PM", "Appointment", "Scheduled\nPediatrician visit"],
  ];

  const LogTable({super.key});

  Color tagColor(String type) {
    switch (type) {
      case "Feeding":
        return const Color(0xFF6B6BFF);
      case "Sleep":
        return Colors.teal;
      case "Medication":
        return Colors.redAccent;
      case "Growth":
        return Colors.grey;
      case "Appointment":
        return Colors.orangeAccent;
      default:
        return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Table(
      columnWidths: const {
        0: FixedColumnWidth(90), // time
        1: FixedColumnWidth(100), // type
        2: FlexColumnWidth(), // details
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: logs.map((log) {
        final color = tagColor(log[1]);
        return TableRow(
          children: [
            // Time
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                log[0],
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            // Type tag
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    log[1],
                    style: TextStyle(
                      fontSize: 12,
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            // Details
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                log[2],
                style: TextStyle(
                  fontSize: 12,
                  height: 1.4,
                  color: isDark ? Colors.grey[400] : Colors.grey[700],
                ),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
