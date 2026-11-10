import 'package:flutter/material.dart';
import 'package:nucleusv2/src/feature/theme/db_colors.dart';

/// Chart / dashboard colours — mapped to the DiBold palette.
class AppColors {
  static const Color cardBgOrgColor = DbColors.primary;
  static const Color cardBgColor = DbColors.slate800;
  static const Color primary = contentColorCyan;
  static const Color menuBackground = DbColors.slate900;
  static const Color itemsBackground = DbColors.slate800;
  static const Color pageBackground = DbColors.slate900;
  static const Color mainTextColor1 = Colors.white;
  static const Color mainTextColor2 = Colors.white70;
  static const Color mainTextColor3 = Colors.white38;
  static const Color mainGridLineColor = Colors.white10;
  static const Color borderColor = Colors.white54;
  static const Color gridLinesColor = Color(0x11FFFFFF);

  static const Color contentColorBlack = Colors.black;
  static const Color contentColorWhite = Colors.white;
  static const Color contentColorBlue = DbColors.primary;
  static const Color contentColorYellow = Color(0xFFF59E0B);
  static const Color contentColorOrange = Color(0xFFF97316);
  static const Color contentColorGreen = Color(0xFF10B981);
  static const Color contentColorPurple = Color(0xFF6366F1);
  static const Color contentColorPink = Color(0xFFEC4899);
  static const Color contentColorRed = Color(0xFFEF4444);
  static const Color contentColorCyan = DbColors.primary400;
}
