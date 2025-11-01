import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tifli/core/constants/icons.dart';
import 'package:tifli/core/constants/app_colors.dart';
import 'package:tifli/features/logs/feeding_logs.dart';
import 'package:tifli/features/logs/sleeping_logs.dart';
import 'package:tifli/features/logs/statistics.dart';

// ---------------------- MAIN PAGE ----------------------
class BottomBarOnly extends StatefulWidget {
  const BottomBarOnly({super.key});

  @override
  State<BottomBarOnly> createState() => _BottomBarOnlyState();
}

class _BottomBarOnlyState extends State<BottomBarOnly>
    with SingleTickerProviderStateMixin {
  bool showOptions = false;
  late AnimationController _controller;
  late Animation<double> _animation;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
  }

  void toggleOptions() {
    setState(() {
      showOptions = !showOptions;
      if (showOptions) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ---------- Pages for navigation ----------
  final List<Widget> _pages = const [
    HomePage(),
    CalendarPage(),
    TrackPage(),
    StatsPage(),
  ];

  // ---------- FAB Options ----------
  final List<Map<String, dynamic>> fabOptions = [
    {'icon': AppIcons.svg(AppIcons.bottle), 'page': const FeedPage()},
    {
      'icon': const Icon(Icons.trending_up, color: AppColors.primary),
      'page': const GrowthPage(),
    },
    {
      'icon': const Icon(Icons.bedtime, color: AppColors.primary),
      'page': const SleepPage(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFFD93B63);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // ---------- Active Page ----------
          _pages[_selectedIndex],

          // ---------- Bottom Navigation ----------
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                // Base navigation bar
                Container(
                  height: 80,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _NavButton(
                        icon: Icons.home,
                        index: 0,
                        selectedIndex: _selectedIndex,
                        onTap: () => setState(() => _selectedIndex = 0),
                      ),
                      _NavButton(
                        icon: Icons.calendar_month,
                        index: 1,
                        selectedIndex: _selectedIndex,
                        onTap: () => setState(() => _selectedIndex = 1),
                      ),
                      const SizedBox(width: 60),
                      _NavButton(
                        icon: Icons.track_changes,
                        index: 2,
                        selectedIndex: _selectedIndex,
                        onTap: () => setState(() => _selectedIndex = 2),
                      ),
                      _NavButton(
                        icon: Icons.bar_chart,
                        index: 3,
                        selectedIndex: _selectedIndex,
                        onTap: () => setState(() => _selectedIndex = 3),
                      ),
                    ],
                  ),
                ),

                // ---------- Circular FAB Options ----------
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    final radius = 90 * _animation.value;

                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        for (int i = 0; i < fabOptions.length; i++)
                          if (showOptions)
                            Transform.translate(
                              offset: Offset(
                                radius * cos(pi / 3 * (i - 1) + pi / 2),
                                -radius * sin(pi / 3 * (i - 1) + pi / 2),
                              ),
                              child: Opacity(
                                opacity: _animation.value,
                                child: _FabOption(
                                  icon: fabOptions[i]['icon'],
                                  color: primary,
                                  onPressed: () {
                                    toggleOptions();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => fabOptions[i]['page'],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                      ],
                    );
                  },
                ),

                // ---------- Main FAB ----------
                Positioned(
                  bottom: 35,
                  child: GestureDetector(
                    onTap: toggleOptions,
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: primary,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFF7F8FC),
                          width: 4,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: RotationTransition(
                        turns: Tween(
                          begin: 0.0,
                          end: 0.125,
                        ).animate(_controller),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 38,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------- NAV BUTTON ----------------------
class _NavButton extends StatelessWidget {
  final IconData icon;
  final int index;
  final int selectedIndex;
  final VoidCallback onTap;

  const _NavButton({
    required this.icon,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = index == selectedIndex;
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        color: isSelected ? AppColors.primary : Colors.grey,
        size: 30,
      ),
    );
  }
}

// ---------------------- FAB OPTION ----------------------
class _FabOption extends StatefulWidget {
  final Widget icon;
  final Color color;
  final VoidCallback onPressed;

  const _FabOption({
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  State<_FabOption> createState() => _FabOptionState();
}

class _FabOptionState extends State<_FabOption> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isHovered = true),
        onTapUp: (_) => setState(() => _isHovered = false),
        onTapCancel: () => setState(() => _isHovered = false),
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 55,
          height: 55,
          decoration: BoxDecoration(
            color: _isHovered ? widget.color.withOpacity(0.15) : Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4),
            ],
          ),
          child: Center(
            child: SizedBox(width: 28, height: 28, child: widget.icon),
          ),
        ),
      ),
    );
  }
}

// ---------------------- Example Pages ----------------------
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) =>
      const Center(child: Text("🏠 Home Page", style: TextStyle(fontSize: 24)));
}

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});
  @override
  Widget build(BuildContext context) => const Center(
    child: Text("📅 Calendar Page", style: TextStyle(fontSize: 24)),
  );
}

class TrackPage extends StatelessWidget {
  const TrackPage({super.key});
  @override
  Widget build(BuildContext context) => const Center(
    child: Text("🎯 Track Page", style: TextStyle(fontSize: 24)),
  );
}

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});
  @override
  Widget build(BuildContext context) => const Center(
    child: Text("📊 Stats Page", style: TextStyle(fontSize: 24)),
  );
}

// ---------- FAB Option Pages ----------
class FeedPage extends StatelessWidget {
  const FeedPage({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(
    body: Center(
      child: Text("🍼 Feeding Page", style: TextStyle(fontSize: 24)),
    ),
  );
}

class GrowthPage extends StatelessWidget {
  const GrowthPage({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(
    body: Center(child: Text("📈 Growth Page", style: TextStyle(fontSize: 24))),
  );
}

class SleepPage extends StatelessWidget {
  const SleepPage({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(
    body: Center(child: Text("😴 Sleep Page", style: TextStyle(fontSize: 24))),
  );
}
