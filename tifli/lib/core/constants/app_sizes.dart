import 'package:flutter/widgets.dart';

class AppSizes {
  // Padding constants
  static const EdgeInsets paddingZero = EdgeInsets.zero;

  // Symmetric paddings
  static const EdgeInsets paddingXS = EdgeInsets.symmetric(
    horizontal: 4.0,
    vertical: 4.0,
  );
  static const EdgeInsets paddingSM = EdgeInsets.symmetric(
    horizontal: 8.0,
    vertical: 8.0,
  );
  static const EdgeInsets paddingMD = EdgeInsets.symmetric(
    horizontal: 12.0,
    vertical: 12.0,
  );
  static const EdgeInsets paddingLG = EdgeInsets.symmetric(
    horizontal: 16.0,
    vertical: 16.0,
  );
  static const EdgeInsets paddingXL = EdgeInsets.symmetric(
    horizontal: 24.0,
    vertical: 24.0,
  );

  // Horizontal only paddings
  static const EdgeInsets paddingHXS = EdgeInsets.symmetric(horizontal: 4.0);
  static const EdgeInsets paddingHSM = EdgeInsets.symmetric(horizontal: 8.0);
  static const EdgeInsets paddingHMD = EdgeInsets.symmetric(horizontal: 12.0);
  static const EdgeInsets paddingHLG = EdgeInsets.symmetric(horizontal: 16.0);
  static const EdgeInsets paddingHXL = EdgeInsets.symmetric(horizontal: 24.0);

  // Vertical only paddings
  static const EdgeInsets paddingVXS = EdgeInsets.symmetric(vertical: 4.0);
  static const EdgeInsets paddingVSM = EdgeInsets.symmetric(vertical: 8.0);
  static const EdgeInsets paddingVMD = EdgeInsets.symmetric(vertical: 12.0);
  static const EdgeInsets paddingVLG = EdgeInsets.symmetric(vertical: 16.0);
  static const EdgeInsets paddingVXL = EdgeInsets.symmetric(vertical: 24.0);

  // All sides padding
  static const EdgeInsets paddingAllXS = EdgeInsets.all(4.0);
  static const EdgeInsets paddingAllSM = EdgeInsets.all(8.0);
  static const EdgeInsets paddingAllMD = EdgeInsets.all(12.0);
  static const EdgeInsets paddingAllLG = EdgeInsets.all(16.0);
  static const EdgeInsets paddingAllXL = EdgeInsets.all(24.0);

  // Screen padding (safe area)
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: 16.0,
    vertical: 24.0,
  );
  static const EdgeInsets contentPadding = EdgeInsets.all(16.0);
  // Private constructor to prevent instantiation
  AppSizes._();

  // Spacing constants
  static const double xs = 4.0; // Extra small
  static const double sm = 8.0; // Small
  static const double md = 12.0; // Medium
  static const double lg = 16.0; // Large
  static const double xl = 24.0; // Extra large
  static const double xxl = 32.0; // Extra extra large

  // Border radius
  static const double radiusXs = 4.0;
  static const double radiusSm = 8.0;
  static const double radius = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;

  // Icon sizes
  static const double iconXs = 16.0;
  static const double iconSm = 20.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;
  static const double iconXl = 48.0;

  // Button sizes
  static const double buttonHeight = 48.0;
  static const double buttonHeightSm = 36.0;
  static const double buttonHeightLg = 56.0;

  // Input fields
  static const double inputHeight = 48.0;
  static const double inputRadius = 8.0;
  static const double inputBorder = 1.0;

  // Card sizes
  static const double cardRadius = 12.0;
  static const double cardElevation = 2.0;
  static const double cardPadding = 16.0;

  // Avatar sizes
  static const double avatarSm = 32.0;
  static const double avatarMd = 48.0;
  static const double avatarLg = 64.0;

  // Default screen padding
  // Default spacing
  static const double defaultSpacing = 16.0;

  // Default gap between sections
  static const double sectionGap = 32.0;
}
