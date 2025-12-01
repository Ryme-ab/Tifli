// lib/profile/parent_profile_screen.dart
import 'package:flutter/material.dart';
import 'package:tifli/widgets/appbar.dart';
import 'package:tifli/core/constants/app_colors.dart';
import 'package:tifli/core/constants/app_fonts.dart';
import 'package:tifli/core/constants/app_assets.dart';

class ParentProfileScreen extends StatefulWidget {
  const ParentProfileScreen({super.key});

  @override
  State<ParentProfileScreen> createState() => _ParentProfileScreenState();
}

class _ParentProfileScreenState extends State<ParentProfileScreen> {
  // === Account Preferences ===
  bool enableNotifications = true;
  bool dailySummaryEmails = false;
  bool shareActivityData = true;
  bool darkMode = false;

  // === User Data Controllers ===
  final TextEditingController _nameController =
      TextEditingController(text: "Eleanor Vance");
  final TextEditingController _emailController =
      TextEditingController(text: "eleanor.vance@example.com");
  final TextEditingController _phoneController =
      TextEditingController(text: "+1 (555) 123-4567");

  // === Edit States ===
  bool _isEditingName = false;
  bool _isEditingEmail = false;
  bool _isEditingPhone = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Parent Profile"),
      backgroundColor: AppColors.backgroundLight,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // === Profile Header ===
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundImage: AssetImage(AppAssets.babyMom),
                    backgroundColor: AppColors.surfaceLight,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _nameController.text,
                    style: AppFonts.heading2.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimaryLight,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _emailController.text,
                    style: AppFonts.small.copyWith(color: AppColors.textSecondaryLight),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // === Personal Information ===
            _buildSectionTitle("Personal Information"),
            const SizedBox(height: 8),
            _buildEditableField(
              "Full Name",
              _nameController,
              _isEditingName,
              onEditTap: () => setState(() => _isEditingName = !_isEditingName),
            ),
            _buildEditableField(
              "Email Address",
              _emailController,
              _isEditingEmail,
              onEditTap: () => setState(() => _isEditingEmail = !_isEditingEmail),
            ),
            _buildEditableField(
              "Phone Number",
              _phoneController,
              _isEditingPhone,
              onEditTap: () => setState(() => _isEditingPhone = !_isEditingPhone),
            ),

            const SizedBox(height: 20),

            // === Account Preferences ===
            _buildSectionTitle("Account Preferences"),
            const SizedBox(height: 8),
            _buildToggle("Enable Notifications", enableNotifications,
                (value) => setState(() => enableNotifications = value)),
            _buildToggle("Daily Summary Emails", dailySummaryEmails,
                (value) => setState(() => dailySummaryEmails = value)),
            _buildToggle("Share Activity Data", shareActivityData,
                (value) => setState(() => shareActivityData = value)),
            _buildToggle("Dark Mode (Coming Soon)", darkMode,
                (value) => setState(() => darkMode = value),
                enabled: false),

            const SizedBox(height: 24),

            // === Buttons ===
            // button to check babies list (light variant)
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/parentProfile'); // adjust route
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary.withValues(alpha: 0.10),
                foregroundColor: AppColors.primary,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: Text(
                "👶 Check your babies list",
                style: AppFonts.body.copyWith(fontWeight: FontWeight.w600),
              ),
            ),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () {
                // perform logout
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.surfaceLight,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: Text(
                "Logout",
                style: AppFonts.body.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.surfaceLight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // === Helper Widgets ===

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: AppFonts.heading2.copyWith(fontSize: 16, color: AppColors.textPrimaryLight),
      ),
    );
  }

  Widget _buildEditableField(
    String label,
    TextEditingController controller,
    bool isEditing, {
    required VoidCallback onEditTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        readOnly: !isEditing,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: AppFonts.small.copyWith(color: AppColors.textSecondaryLight),
          suffixIcon: IconButton(
            icon: Icon(
              isEditing ? Icons.check_circle : Icons.edit,
              color: isEditing ? AppColors.success : AppColors.iconLight,
            ),
            onPressed: onEditTap,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          filled: true,
          fillColor: AppColors.surfaceLight,
        ),
        style: AppFonts.body.copyWith(fontSize: 15, color: AppColors.textPrimaryLight),
        cursorColor: AppColors.primary,
      ),
    );
  }

  Widget _buildToggle(
    String title,
    bool value,
    Function(bool) onChanged, {
    bool enabled = true,
  }) {
    return SwitchListTile(
      title: Text(title, style: AppFonts.body),
      value: value,
      onChanged: enabled ? onChanged : null,
      activeThumbColor: AppColors.primary,
      contentPadding: EdgeInsets.zero,
    );
  }
}
