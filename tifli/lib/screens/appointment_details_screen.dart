// lib/screens/appointment_details_screen.dart
//
// Functional Appointment Details screen:
// - Doctor & Location card (avatar, name, specialty, location)
// - Date & Time card (pick date & start/end times with native pickers)
// - Notes card (editable when in edit mode)
// - Reminder settings: toggle + frequency picker modal
// - Edit and Delete actions (Edit toggles editable mode, Delete asks for confirmation)
// - Uses shared tokens from core: AppColors, AppFonts, AppSizes
//
// Drop into your project and wire route '/appointment-details' to this widget.

import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_fonts.dart';
import '../core/constants/app_sizes.dart';
import 'package:intl/intl.dart'; // add intl to pubspec if not present

class AppointmentDetailsScreen extends StatefulWidget {
  const AppointmentDetailsScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentDetailsScreen> createState() => _AppointmentDetailsScreenState();
}

class _AppointmentDetailsScreenState extends State<AppointmentDetailsScreen> {
  // Example appointment state
  DateTime _date = DateTime.now().add(const Duration(days: 7));
  TimeOfDay _startTime = const TimeOfDay(hour: 10, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 11, minute: 0);

  String _notes =
      "Follow-up visit for baby's 6-month check-up. Discuss sleep regression, solids introduction, and vaccination schedule. Prepare a list of questions for Dr. Vance regarding baby's recent fussiness. Bring baby's health record book and insurance details.";

  bool _editing = false;

  // Reminder settings
  bool _remindersEnabled = true;
  String _reminderFrequency = '24 hours before'; // display text

  // Doctor info (could come from args)
  final String _doctorName = 'Dr. Elara Vance';
  final String _doctorSpecialty = 'Pediatrician Specialist';
  final String _locationLabel = 'Dreamland Pediatric Clinic, Suite 205';
  final String _avatarAsset = 'assets/images/doctor_avatar.png'; // replace with your asset

  // Helpers
  String get _dateLabel => DateFormat.yMMMMd().format(_date);
  String _formatTimeOfDay(TimeOfDay t) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, t.hour, t.minute);
    return DateFormat.jm().format(dt);
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    );
    if (picked != null) {
      setState(() => _date = picked);
    }
  }

  Future<void> _pickStartTime() async {
    final picked = await showTimePicker(context: context, initialTime: _startTime);
    if (picked != null) {
      setState(() {
        _startTime = picked;
        // ensure end time is after start time
        final startMinutes = _startTime.hour * 60 + _startTime.minute;
        final endMinutes = _endTime.hour * 60 + _endTime.minute;
        if (endMinutes <= startMinutes) {
          final newEnd = startMinutes + 30;
          _endTime = TimeOfDay(hour: newEnd ~/ 60, minute: newEnd % 60);
        }
      });
    }
  }

  Future<void> _pickEndTime() async {
    final picked = await showTimePicker(context: context, initialTime: _endTime);
    if (picked != null) {
      setState(() {
        _endTime = picked;
        // ensure end > start; if not, push end 30 minutes after start
        final startMinutes = _startTime.hour * 60 + _startTime.minute;
        final endMinutes = _endTime.hour * 60 + _endTime.minute;
        if (endMinutes <= startMinutes) {
          final newEnd = startMinutes + 30;
          _endTime = TimeOfDay(hour: newEnd ~/ 60, minute: newEnd % 60);
        }
      });
    }
  }

  Future<void> _editNotes() async {
    final controller = TextEditingController(text: _notes);
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit Notes'),
        content: SizedBox(
          width: double.maxFinite,
          child: TextField(
            controller: controller,
            maxLines: 8,
            decoration: const InputDecoration(hintText: 'Notes...'),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => Navigator.pop(ctx, controller.text), child: const Text('Save')),
        ],
      ),
    );

    if (result != null) {
      setState(() => _notes = result);
    }
  }

  Future<void> _pickReminderFrequency() async {
    final options = ['24 hours before', '12 hours before', '3 hours before', '1 hour before', '15 minutes before'];
    final picked = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Text('Reminder Frequency', style: AppFonts.heading2),
              const SizedBox(height: 8),
              ...options.map((o) {
                final selected = o == _reminderFrequency;
                return ListTile(
                  title: Text(o, style: AppFonts.body),
                  trailing: selected ? Icon(Icons.check, color: AppColors.primary) : null,
                  onTap: () => Navigator.pop(ctx, o),
                );
              }).toList(),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );

    if (picked != null) {
      setState(() => _reminderFrequency = picked);
    }
  }

  Future<void> _confirmDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete appointment'),
        content: const Text('Are you sure you want to delete this appointment?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Delete')),
        ],
      ),
    );

    if (confirmed == true) {
      // For demo just pop back. In real app delete from storage / server.
      Navigator.pop(context);
    }
  }

  void _toggleEditing() {
    setState(() => _editing = !_editing);
  }

  @override
  Widget build(BuildContext context) {
    // inset-aware padding
    final media = MediaQuery.of(context);
    final bottomInset = media.viewInsets.bottom + media.padding.bottom + AppSizes.md;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundLight,
        elevation: 0,
        centerTitle: true,
        title: Text('Appointment Details', style: AppFonts.heading2),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            color: AppColors.textPrimaryLight,
            onPressed: () {}, // optional notifications settings
          ),
          Padding(
            padding: const EdgeInsets.only(right: AppSizes.md),
            child: CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage(_avatarAsset),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(AppSizes.lg, AppSizes.md, AppSizes.lg, bottomInset),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    _buildDoctorCard(),
                    const SizedBox(height: AppSizes.lg),
                    _buildDateTimeCard(),
                    const SizedBox(height: AppSizes.lg),
                    _buildNotesCard(),
                    const SizedBox(height: AppSizes.lg),
                    _buildReminderCard(),
                    const SizedBox(height: AppSizes.lg),
                    _buildActionButtonsRow(),
                    const SizedBox(height: AppSizes.md),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorCard() {
    return Container(
      padding: const EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.radius),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(_avatarAsset),
          ),
          const SizedBox(width: AppSizes.md),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(_doctorName, style: AppFonts.body?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: AppSizes.xs),
              Text(_doctorSpecialty, style: AppFonts.body?.copyWith(color: AppColors.textPrimaryLight)),
              const SizedBox(height: AppSizes.sm),
              Row(
                children: [
                  const Icon(Icons.location_on_outlined, size: 16),
                  const SizedBox(width: 6),
                  Expanded(child: Text(_locationLabel, style: AppFonts.body?.copyWith(fontSize: 12, color: AppColors.textPrimaryLight))),
                ],
              )
            ]),
          )
        ],
      ),
    );
  }

  Widget _buildDateTimeCard() {
    return Container(
      padding: const EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.radius),
        border: Border.all(color: AppColors.primary.withOpacity(0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Date & Time', style: AppFonts.body?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: AppSizes.sm),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: _pickDate,
                  child: Container(
                    padding: const EdgeInsets.all(AppSizes.sm),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                      color: AppColors.backgroundLight,
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today_outlined, size: 18),
                        const SizedBox(width: 8),
                        Expanded(child: Text(_dateLabel, style: AppFonts.body)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSizes.md),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: _pickStartTime,
                        child: Container(
                          padding: const EdgeInsets.all(AppSizes.sm),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                            color: AppColors.backgroundLight,
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.access_time_outlined, size: 18),
                              const SizedBox(width: 8),
                              Expanded(child: Text(_formatTimeOfDay(_startTime), style: AppFonts.body)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text('-', style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: InkWell(
                        onTap: _pickEndTime,
                        child: Container(
                          padding: const EdgeInsets.all(AppSizes.sm),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                            color: AppColors.backgroundLight,
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.access_time_outlined, size: 18),
                              const SizedBox(width: 8),
                              Expanded(child: Text(_formatTimeOfDay(_endTime), style: AppFonts.body)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildNotesCard() {
    return Container(
      padding: const EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.radius),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4, offset: const Offset(0, 1))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Notes', style: AppFonts.body?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: AppSizes.sm),
        _editing
            ? TextField(
                controller: TextEditingController(text: _notes),
                maxLines: 6,
                onChanged: (v) => _notes = v,
                decoration: const InputDecoration(border: InputBorder.none),
                style: AppFonts.body,
              )
            : Text(_notes, style: AppFonts.body?.copyWith(color: AppColors.textPrimaryLight)),
        const SizedBox(height: AppSizes.sm),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: _editing ? () => setState(() => _editing = false) : _editNotes,
            icon: Icon(_editing ? Icons.check : Icons.edit, color: AppColors.primary),
            label: Text(_editing ? 'Save' : 'Edit', style: AppFonts.body?.copyWith(color: AppColors.primary)),
          ),
        )
      ]),
    );
  }

  Widget _buildReminderCard() {
    return Container(
      padding: const EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.radius),
        border: Border.all(color: AppColors.primary.withOpacity(0.06)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Reminder Settings', style: AppFonts.body?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: AppSizes.sm),
        Row(
          children: [
            Expanded(child: Text('Enable Reminders', style: AppFonts.body)),
            Switch(
              value: _remindersEnabled,
              activeColor: AppColors.primary,
              onChanged: (v) => setState(() => _remindersEnabled = v),
            )
          ],
        ),
        const SizedBox(height: AppSizes.sm),
        Row(
          children: [
            Expanded(
              child: Text('Reminder Frequency', style: AppFonts.body?.copyWith(color: AppColors.textPrimaryLight)),
            ),
            TextButton(
              onPressed: _remindersEnabled ? _pickReminderFrequency : null,
              style: TextButton.styleFrom(
                backgroundColor: AppColors.primary.withOpacity(0.06),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radiusSm)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.alarm, color: AppColors.primary),
                  const SizedBox(width: 8),
                  Text(_reminderFrequency, style: AppFonts.body?.copyWith(color: AppColors.primary)),
                ],
              ),
            ),
          ],
        ),
      ]),
    );
  }

  Widget _buildActionButtonsRow() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _toggleEditing,
            icon: const Icon(Icons.edit),
            label: Text(_editing ? 'Done' : 'Edit', style: AppFonts.body),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radius)),
            ),
          ),
        ),
        const SizedBox(width: AppSizes.md),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _confirmDelete,
            icon: const Icon(Icons.delete_outline),
            label: Text('Delete', style: AppFonts.body?.copyWith(color: AppColors.primary)),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.primary),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radius)),
              backgroundColor: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
