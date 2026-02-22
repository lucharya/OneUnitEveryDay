import 'package:flutter/material.dart';

/// Design tokens for colors - minimalist, neutral charcoal palette
abstract final class AppColors {
  // Primary — warm charcoal / near-black (Zinc-inspired)
  static const Color primary = Color(0xFF1C1917);       // Stone 950
  static const Color primaryLight = Color(0xFF44403C);   // Stone 700
  static const Color primaryDark = Color(0xFF0C0A09);    // Stone 950+

  // Surface
  static const Color surface = Color(0xFFFAFAF9);        // Stone 50
  static const Color surfaceVariant = Color(0xFFF5F5F4);  // Stone 100
  static const Color background = Color(0xFFFFFFFF);

  // Text
  static const Color textPrimary = Color(0xFF1C1917);     // Stone 900
  static const Color textSecondary = Color(0xFF78716C);    // Stone 500
  static const Color textTertiary = Color(0xFFA8A29E);     // Stone 400

  // Status
  static const Color success = Color(0xFF16A34A);          // Green 600
  static const Color successLight = Color(0xFFDCFCE7);     // Green 100
  static const Color error = Color(0xFFDC2626);            // Red 600
  static const Color errorLight = Color(0xFFFEE2E2);       // Red 100

  // Streak / Fire
  static const Color streakActive = Color(0xFFEA580C);     // Orange 600
  static const Color streakActiveLight = Color(0xFFFFF7ED); // Orange 50
  static const Color fire = Color(0xFFEF4444);              // Red 500
  static const Color fireLight = Color(0xFFFEF2F2);         // Red 50

  // Calendar
  static const Color calendarCompleted = Color(0xFFEF4444); // Red 500 (fire pin)
  static const Color calendarCompletedLight = Color(0xFFFEF2F2);
  static const Color calendarToday = Color(0xFF1C1917);     // Stone 900
  static const Color calendarDefault = Color(0xFFE7E5E4);   // Stone 200

  // Borders & dividers
  static const Color border = Color(0xFFE7E5E4);           // Stone 200
  static const Color divider = Color(0xFFF5F5F4);          // Stone 100

  // Shadows
  static const Color shadow = Color(0x0D000000);
}
