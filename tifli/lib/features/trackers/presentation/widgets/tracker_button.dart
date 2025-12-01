import 'package:flutter/material.dart';

class TrackerButton extends StatelessWidget {
  final IconData icon;
  final Color borderColor;
  final Color activeColor;
  final bool isActive;
  final VoidCallback? onTap; // ✅ add this

  const TrackerButton({
    super.key,
    required this.icon,
    required this.borderColor,
    required this.activeColor,
    required this.isActive,
    this.onTap, // ✅ add this
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // ✅ add this
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isActive ? activeColor.withValues(alpha: 0.2) : Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: borderColor, width: 2),
        ),
        child: Icon(icon, color: borderColor, size: 30),
      ),
    );
  }
}
