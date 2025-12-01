import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final accentColor = const Color(0xFFF56587); // Baby logs pink
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF111C21)
          : const Color(0xFFF6F7F8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 40),
                      const Text(
                        "Logs & Reports",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.notifications),
                          const SizedBox(width: 10),
                          CircleAvatar(
                            backgroundColor: isDark
                                ? Colors.grey.shade700
                                : Colors.grey.shade300,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Navigation Tabs
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: isDark
                            ? Colors.grey.shade700
                            : Colors.grey.shade300,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _navItem("Home", false, accentColor),
                      _navItem("Schedule", false, accentColor),
                      _navItem("Track", false, accentColor),
                      _navItem("Logs", true, accentColor),
                      _navItem("Resources", false, accentColor),
                    ],
                  ),
                ),

                // Date selector
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1A282F) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: accentColor.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              "Daily",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: accentColor,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Weekly",
                            style: TextStyle(
                              color: isDark
                                  ? Colors.grey.shade400
                                  : Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: accentColor,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          const Text("October 26, 2024"),
                        ],
                      ),
                    ],
                  ),
                ),

                // Stats Cards
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      StatCard(
                        title: "Total Active Users",
                        value: "1,250",
                        color: accentColor,
                      ),
                      StatCard(
                        title: "New Registrations Today",
                        value: "42",
                        color: accentColor,
                      ),
                      StatCard(
                        title: "System Health Status",
                        value: "Operational",
                        color: Colors.green,
                      ),
                    ],
                  ),
                ),

                // Activity Logs
                const Padding(
                  padding: EdgeInsets.only(left: 16, top: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Recent Admin Actions",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1A282F) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      ActionItem(
                        time: "10:30 AM",
                        tag: "User Mgmt",
                        tagColor: accentColor,
                        details: "Password reset for user #5821",
                      ),
                      ActionItem(
                        time: "09:00 AM",
                        tag: "System",
                        tagColor: Colors.green,
                        details: "Database backup completed",
                      ),
                      ActionItem(
                        time: "07:00 AM",
                        tag: "Alert",
                        tagColor: Colors.red,
                        details: "Failed login attempt detected",
                      ),
                      const ActionItem(
                        time: "Yesterday",
                        tag: "Deployment",
                        tagColor: Colors.purple,
                        details: "Pushed v2.1.3 to production",
                        showDivider: false,
                      ),
                    ],
                  ),
                ),

                // Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: accentColor,
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {},
                        icon: const Icon(Icons.group, color: Colors.white),
                        label: const Text(
                          "Manage User Accounts",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 10),
                      OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: accentColor),
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {},
                        icon: Icon(Icons.bar_chart, color: accentColor),
                        label: Text(
                          "View All System Reports",
                          style: TextStyle(color: accentColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        selectedItemColor: accentColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "Schedule",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: "Track"),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: "Logs",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Resources"),
        ],
      ),
    );
  }

  Widget _navItem(String title, bool active, Color accentColor) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: active ? accentColor : Colors.grey,
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        if (active)
          Container(
            margin: const EdgeInsets.only(top: 4),
            height: 2,
            width: 30,
            color: accentColor,
          ),
      ],
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: color, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class ActionItem extends StatelessWidget {
  final String time;
  final String tag;
  final String details;
  final Color tagColor;
  final bool showDivider;

  const ActionItem({
    super.key,
    required this.time,
    required this.tag,
    required this.details,
    required this.tagColor,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              time,
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: tagColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                tag,
                style: TextStyle(
                  color: tagColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              width: 140,
              child: Text(
                details,
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
        if (showDivider)
          Divider(
            color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
            height: 12,
          ),
      ],
    );
  }
}
