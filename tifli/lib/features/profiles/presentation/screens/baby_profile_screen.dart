// lib/profile/baby_profile_screen.dart
import 'package:flutter/material.dart';
import 'package:tifli/core/constants/app_colors.dart';
import 'package:tifli/core/constants/app_fonts.dart';
import 'package:tifli/core/constants/app_assets.dart';
import 'package:tifli/widgets/appbar.dart';

class BabyProfileScreen extends StatelessWidget {
  const BabyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // sample data — in real app, pass a Baby model to this page
    final String name = "islam";
    final String subtitle = "happy and healthy";
    final String dob = "October 15, 2023";
    final String gender = "Female";
    final String notes = "Islam loves bright colors and giggles when she sees her favorite soft toy, a pink bunny. She recently started trying solid foods, with a particular fondness for pureed carrots. No known allergies.";

    return Scaffold(
      appBar: const CustomAppBar(title: "Baby Profile"),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // top card with avatar and name
            Container(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
              decoration: BoxDecoration(
                color: const Color(0xFFEFFAFB), // very light aqua from screenshot
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.withValues(alpha: 0.08)),
              ),
              child: Row(
                children: [
                  // avatar
                  CircleAvatar(
                    radius: 36,
                    backgroundImage: AssetImage(AppAssets.baby1),
                    backgroundColor: Colors.grey[100],
                  ),
                  const SizedBox(width: 14),
                  // name & subtitle
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: AppFonts.heading2.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimaryLight,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          subtitle,
                          style: AppFonts.body.copyWith(
                            fontSize: 13,
                            color: AppColors.textSecondaryLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // edit icon (floating small)
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.withValues(alpha: 0.12)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 6,
                          offset: const Offset(0,2),
                        )
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.edit, size: 18),
                      onPressed: () {
                        // open edit profile
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // Basic Information card
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.withValues(alpha: 0.12)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 8,
                    offset: const Offset(0,4),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // header row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Basic Information", style: AppFonts.heading2.copyWith(fontSize: 14)),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit, size: 18),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  // row: dob
                  Row(
                    children: [
                      const Icon(Icons.cake, size: 18),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text("Date of birth", style: AppFonts.small),
                      ),
                      Text(dob, style: AppFonts.body),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // row: gender
                  Row(
                    children: [
                      const Icon(Icons.wc, size: 18),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text("Gender", style: AppFonts.small),
                      ),
                      Text(gender, style: AppFonts.body),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Additional notes card (yellow background)
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.warning.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.warning.withValues(alpha: 0.14)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Additional notes", style: AppFonts.heading2.copyWith(fontSize: 14)),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit, size: 18),
                      )
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    notes,
                    style: AppFonts.body.copyWith(fontSize: 13),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            // Edit baby details button (full width)
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  // navigate to edit details
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                ),
                child: const Text(
                  "Edit baby details",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),

            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}
