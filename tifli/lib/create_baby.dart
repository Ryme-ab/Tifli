import 'package:flutter/material.dart';

void main() {
  runApp(const AddBabyPage());
}

class AddBabyPage extends StatelessWidget {
  const AddBabyPage({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFFBE185D);
    const backgroundLight = Color(0xFFF8FAFC);
    const backgroundDark = Color(0xFF1E293B);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light, // default: light mode
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: const ColorScheme.light(
          primary: primaryColor,
          background: backgroundLight,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Poppins',
        colorScheme: const ColorScheme.dark(
          primary: primaryColor,
          background: backgroundDark,
        ),
      ),
      home: const AddBabyScreen(),
    );
  }
}

class AddBabyScreen extends StatefulWidget {
  const AddBabyScreen({super.key});

  @override
  State<AddBabyScreen> createState() => _AddBabyScreenState();
}

class _AddBabyScreenState extends State<AddBabyScreen> {
  bool isBoy = true;

  // Form key and controllers
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  
  // For birth date
  final _birthController = TextEditingController();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    const primaryColor = Color(0xFFBE185D);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 32),
                  const Text(
                    "Add Baby",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  Row(
                    children: [
                      Icon(Icons.notifications_outlined,
                          color: isDark ? Colors.grey[400] : Colors.grey[600]),
                      const SizedBox(width: 8),
                      const CircleAvatar(
                        radius: 16,
                        backgroundImage: NetworkImage(
                          "https://lh3.googleusercontent.com/aida-public/AB6AXuDuMey8NecJDultkiB-RGmzAohd7zpgs7Ircr0W7Zo9NfVmEybQ3HvahZne72Mz5W_8n9_5VB744gIq9VbRxkQrfMxA2uAnYQz4fQlu5PKasUmKxEqpkC12liu9_KfXXeDohbLOdTqic1mOYVEXiDSuAqMV3MwfCGF_Bux2W5oMxJFKxVmFG4vH68wY5cue7AkqxxkwZzTQV3MwzCn_BM4iKtrUxpXJ_S1gtnBOa0g96o8sHxrJLGjfyqi9KbnlUnv5_fd0Lszyml8",
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

            // Dots
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 12,
                      height: 4,
                      decoration: BoxDecoration(
                          color: isDark ? Colors.grey[600] : Colors.grey[400],
                          borderRadius: BorderRadius.circular(8))),
                  const SizedBox(width: 6),
                  Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                          color: isDark ? Colors.grey[600] : Colors.grey[400],
                          borderRadius: BorderRadius.circular(8))),
                  const SizedBox(width: 6),
                  Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                          color: isDark ? Colors.grey[600] : Colors.grey[400],
                          borderRadius: BorderRadius.circular(8))),
                ],
              ),
            ),

            // Form
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.black26 : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      if (!isDark)
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        )
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Baby Details",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Provide essential information about your little one.",
                          style: TextStyle(
                            color:
                                isDark ? Colors.grey[400] : Colors.grey.shade600,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Baby Name
                        _buildTextFormField(
                          label: "Baby's Name",
                          hint: "E.g., Luna, Leo",
                          controller: _nameController,
                          isDark: isDark,
                          validator: (v) =>
                              v!.isEmpty ? "Please enter baby's name" : null,
                        ),
                        const SizedBox(height: 20),

                        // Birth Date - Updated with date picker
                        _buildDatePickerField(
                          label: "Birth Date",
                          hint: "Select birth date",
                          controller: _birthController,
                          isDark: isDark,
                          selectedDate: _selectedDate,
                          onTap: () => _selectDate(context),
                          validator: (v) =>
                              v!.isEmpty ? "Please select birth date" : null,
                        ),
                        const SizedBox(height: 20),

                        // Height
                        _buildNumericFormField(
                          label: "Baby's Height",
                          hint: "E.g., 30 cm",
                          controller: _heightController,
                          isDark: isDark,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "Please enter height";
                            }
                            if (!_isNumeric(v)) {
                              return "Please enter numbers only";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),

                        // Weight
                        _buildNumericFormField(
                          label: "Baby's Weight",
                          hint: "E.g., 3.5 kg",
                          controller: _weightController,
                          isDark: isDark,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "Please enter weight";
                            }
                            if (!_isNumeric(v)) {
                              return "Please enter numbers only";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),

                        // Gender
                        Text(
                          "Gender",
                          style: TextStyle(
                              color: isDark
                                  ? Colors.grey[300]
                                  : Colors.grey.shade700,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () => setState(() => isBoy = true),
                                icon: const Icon(Icons.child_care, size: 18),
                                label: const Text("Boy"),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: isBoy
                                      ? Colors.cyan[700]
                                      : Colors.cyan[300],
                                  backgroundColor: isBoy
                                      ? Colors.cyan[100]
                                      : (isDark
                                          ? Colors.cyan[900]!.withOpacity(0.4)
                                          : Colors.grey[100]),
                                  shape: const StadiumBorder(),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14, horizontal: 8),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () => setState(() => isBoy = false),
                                icon: const Icon(Icons.face_3, size: 18),
                                label: const Text("Girl"),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: !isBoy
                                      ? primaryColor
                                      : Colors.pink.shade300,
                                  backgroundColor: !isBoy
                                      ? const Color(0xFFFFE4E9)
                                      : (isDark
                                          ? Colors.pink.shade900
                                              .withOpacity(0.4)
                                          : Colors.grey[100]),
                                  shape: const StadiumBorder(),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14, horizontal: 8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Save Button
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: isDark ? Colors.black26 : Colors.white,
                border: Border(
                  top: BorderSide(
                    color: isDark
                        ? Colors.grey.shade800
                        : Colors.grey.shade200,
                  ),
                ),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Baby details saved successfully!"),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                child: const Text(
                  "Save Baby",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Date picker function
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFBE185D),
              onPrimary: Colors.white,
            ),
            dialogBackgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white,
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _birthController.text = _formatDate(picked);
      });
    }
  }

  // Format date to display
  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  // Helper method to check if string is numeric (allows decimals)
  bool _isNumeric(String str) {
    if (str.isEmpty) return false;
    // Allow numbers with optional decimal point
    final numericRegex = RegExp(r'^\d*\.?\d*$');
    return numericRegex.hasMatch(str);
  }

  Widget _buildTextFormField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required bool isDark,
    IconData? prefixIcon,
    String? Function(String?)? validator,
  }) {
    const primaryColor = Color(0xFFBE185D);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              color: isDark ? Colors.grey[300] : Colors.grey.shade700,
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon,
                    color: isDark
                        ? Colors.grey[500]
                        : Colors.grey.shade500,
                    size: 18)
                : null,
            hintText: hint,
            filled: true,
            fillColor: isDark ? Colors.grey[850] : Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                  color: isDark
                      ? Colors.grey.shade700
                      : Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: primaryColor),
            ),
          ),
        ),
      ],
    );
  }

  // New method for date picker field
  Widget _buildDatePickerField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required bool isDark,
    required DateTime? selectedDate,
    required VoidCallback onTap,
    String? Function(String?)? validator,
  }) {
    const primaryColor = Color(0xFFBE185D);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              color: isDark ? Colors.grey[300] : Colors.grey.shade700,
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: AbsorbPointer(
            child: TextFormField(
              controller: controller,
              validator: validator,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.calendar_today_outlined,
                    color: isDark ? Colors.grey[500] : Colors.grey.shade500,
                    size: 18),
                hintText: hint,
                filled: true,
                fillColor: isDark ? Colors.grey[850] : Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                      color: isDark
                          ? Colors.grey.shade700
                          : Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: primaryColor),
                ),
                suffixIcon: Icon(
                  Icons.arrow_drop_down,
                  color: isDark ? Colors.grey[500] : Colors.grey.shade500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Method for numeric-only fields
  Widget _buildNumericFormField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required bool isDark,
    String? Function(String?)? validator,
  }) {
    const primaryColor = Color(0xFFBE185D);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              color: isDark ? Colors.grey[300] : Colors.grey.shade700,
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: isDark ? Colors.grey[850] : Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                  color: isDark
                      ? Colors.grey.shade700
                      : Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}