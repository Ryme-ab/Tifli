import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tifli/core/constants/app_colors.dart';
import 'package:tifli/core/constants/app_fonts.dart';
import 'package:tifli/core/constants/app_sizes.dart';

class MealPlannerScreenV2 extends StatefulWidget {
  const MealPlannerScreenV2({super.key});

  @override
  _MealPlannerScreenV2State createState() => _MealPlannerScreenV2State();
}

class _MealPlannerScreenV2State extends State<MealPlannerScreenV2> {
  // Meals are stored by date
  final Map<DateTime, List<Map<String, dynamic>>> _mealsByDate = {};

  DateTime _selectedDate = DateTime.now();

  // Helper: get meals for current date
  List<Map<String, dynamic>> get _mealsForSelectedDate {
    final normalized = _normalizeDate(_selectedDate);
    return _mealsByDate[normalized] ?? [];
  }

  // Normalize date (strip time)
  DateTime _normalizeDate(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  // Toggle checked meal
  void _toggleChecked(String id) {
    final dateKey = _normalizeDate(_selectedDate);
    setState(() {
      final meals = _mealsByDate[dateKey];
      if (meals == null) return;
      final idx = meals.indexWhere((m) => m['id'] == id);
      if (idx != -1) meals[idx]['checked'] = !meals[idx]['checked'];
    });
  }

  // Add or edit meal
  Future<void> _showAddOrEdit({String? id}) async {
    String title = '';
    String subtitle = '';
    final dateKey = _normalizeDate(_selectedDate);
    final meals = _mealsByDate[dateKey] ?? [];

    if (id != null) {
      final idx = meals.indexWhere((m) => m['id'] == id);
      if (idx != -1) {
        title = meals[idx]['title'];
        subtitle = meals[idx]['subtitle'];
      }
    }

    final titleController = TextEditingController(text: title);
    final subtitleController = TextEditingController(text: subtitle);

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(ctx).unfocus(),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(ctx).viewInsets.bottom,
            ),
            child: Container(
              padding: const EdgeInsets.all(AppSizes.lg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(AppSizes.radius),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    id == null ? 'Add Meal' : 'Edit Meal',
                    style: AppFonts.heading1,
                  ),
                  const SizedBox(height: AppSizes.md),
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(hintText: 'Meal title'),
                    textCapitalization: TextCapitalization.words,
                  ),
                  const SizedBox(height: AppSizes.sm),
                  TextField(
                    controller: subtitleController,
                    decoration: const InputDecoration(hintText: 'Subtitle'),
                  ),
                  const SizedBox(height: AppSizes.md),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: AppSizes.sm),
                      ElevatedButton(
                        onPressed: () {
                          final t = titleController.text.trim();
                          final s = subtitleController.text.trim();
                          if (t.isEmpty) return;

                          setState(() {
                            final normalized = _normalizeDate(_selectedDate);
                            _mealsByDate.putIfAbsent(normalized, () => []);
                            if (id == null) {
                              final newId = DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString();
                              _mealsByDate[normalized]!.insert(0, {
                                "id": newId,
                                "title": t,
                                "subtitle": s,
                                "checked": false,
                              });
                            } else {
                              final idx = _mealsByDate[normalized]!.indexWhere(
                                (m) => m['id'] == id,
                              );
                              if (idx != -1) {
                                _mealsByDate[normalized]![idx]['title'] = t;
                                _mealsByDate[normalized]![idx]['subtitle'] = s;
                              }
                            }
                          });

                          Navigator.pop(ctx);
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _deleteMeal(String id) {
    final dateKey = _normalizeDate(_selectedDate);
    setState(() {
      _mealsByDate[dateKey]?.removeWhere((m) => m['id'] == id);
    });
  }

  void _showOptions(String id) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit'),
                onTap: () {
                  Navigator.pop(ctx);
                  _showAddOrEdit(id: id);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_outline),
                title: const Text('Delete'),
                onTap: () {
                  Navigator.pop(ctx);
                  _deleteMeal(id);
                },
              ),
              ListTile(
                leading: const Icon(Icons.open_in_new),
                title: const Text('Open Details'),
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.pushNamed(
                    context,
                    '/meal-details',
                    arguments: {'id': id},
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // --- Calendar logic ---

  DateTime get _startOfWeek =>
      _selectedDate.subtract(Duration(days: _selectedDate.weekday % 7));

  void _goToPreviousWeek() {
    setState(() {
      _selectedDate = _selectedDate.subtract(const Duration(days: 7));
    });
  }

  void _goToNextWeek() {
    setState(() {
      _selectedDate = _selectedDate.add(const Duration(days: 7));
    });
  }

  void _selectDay(DateTime day) {
    setState(() {
      _selectedDate = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dateLabel = DateFormat('EEEE, MMM d').format(_selectedDate);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.backgroundLight,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundLight,
          elevation: 0,
          centerTitle: true,
          title: Text('Meal Planner', style: AppFonts.heading1),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDateStrip(dateLabel),
                const SizedBox(height: AppSizes.md),
                Text(
                  'Planned Meals',
                  style: AppFonts.body.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: AppSizes.sm),
                Expanded(
                  child: _mealsForSelectedDate.isEmpty
                      ? Center(
                          child: Text(
                            'No meals planned for this day',
                            style: AppFonts.body.copyWith(
                              color: AppColors.textPrimaryLight,
                            ),
                          ),
                        )
                      : ListView.separated(
                          padding: EdgeInsets.zero,
                          itemCount: _mealsForSelectedDate.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: AppSizes.md),
                          itemBuilder: (context, index) {
                            final meal = _mealsForSelectedDate[index];
                            return MealCardV2(
                              meal: meal,
                              onCheck: () => _toggleChecked(meal['id']),
                              onMore: () => _showOptions(meal['id']),
                              onTap: () => Navigator.pushNamed(
                                context,
                                '/meal-details',
                                arguments: {'id': meal['id']},
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddOrEdit(),
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildDateStrip(String dateLabel) {
    final startOfWeek = _startOfWeek;

    return Container(
      padding: const EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.radius),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.12)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: _goToPreviousWeek,
              ),
              Text(dateLabel, style: AppFonts.body),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: _goToNextWeek,
              ),
            ],
          ),
          const SizedBox(height: AppSizes.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (index) {
              final day = startOfWeek.add(Duration(days: index));
              final label = DateFormat('E').format(day); // Sun, Mon, etc.
              final isSelected =
                  _normalizeDate(day) == _normalizeDate(_selectedDate);

              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSizes.xs),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                    onTap: () => _selectDay(day),
                    child: Container(
                      height: 36,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.backgroundLight,
                        borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                      ),
                      child: Text(
                        label,
                        style: AppFonts.body.copyWith(
                          color: isSelected
                              ? Colors.white
                              : AppColors.textPrimaryLight,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class MealCardV2 extends StatelessWidget {
  final Map<String, dynamic> meal;
  final VoidCallback? onCheck;
  final VoidCallback? onMore;
  final VoidCallback? onTap;

  const MealCardV2({
    super.key,
    required this.meal,
    this.onCheck,
    this.onMore,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.radius),
      child: Container(
        padding: const EdgeInsets.all(AppSizes.md),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSizes.radius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: onCheck,
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: meal['checked']
                      ? AppColors.primary
                      : AppColors.backgroundLight,
                  borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                  border: Border.all(
                    color: meal['checked']
                        ? AppColors.primary
                        : AppColors.primary.withValues(alpha: 0.12),
                  ),
                ),
                child: meal['checked']
                    ? const Icon(Icons.check, color: Colors.white)
                    : null,
              ),
            ),
            const SizedBox(width: AppSizes.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal['title'],
                    style: AppFonts.body.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: AppSizes.xs),
                  Text(
                    meal['subtitle'],
                    style: AppFonts.body.copyWith(
                      color: AppColors.textPrimaryLight,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSizes.sm),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.backgroundLight,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.12)),
              ),
              child: IconButton(
                icon: Icon(Icons.more_horiz, color: AppColors.primary),
                onPressed: onMore,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
