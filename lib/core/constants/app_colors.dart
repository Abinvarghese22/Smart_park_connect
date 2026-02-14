import 'package:flutter/material.dart';

/// App-wide color constants matching the reference design
/// Primary: Deep purple/blue (#5B4CFF), Accent: Vibrant purple (#7C3AED)
class AppColors {
  AppColors._();

  // Primary brand colors
  static const Color primary = Color(0xFF5B4CFF);
  static const Color primaryLight = Color(0xFF7C6AFF);
  static const Color primaryDark = Color(0xFF3D2DB8);
  static const Color accent = Color(0xFF7C3AED);

  // Splash screen blue
  static const Color splashBlue = Color(0xFF2979FF);

  // Background colors
  static const Color backgroundLight = Color(0xFFF8F9FE);
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E2C);

  // Text colors
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textHint = Color(0xFF9CA3AF);
  static const Color textWhite = Color(0xFFFFFFFF);

  // Status colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Card and border colors
  static const Color cardBorder = Color(0xFFE5E7EB);
  static const Color divider = Color(0xFFF3F4F6);
  static const Color shimmerBase = Color(0xFFE0E0E0);
  static const Color shimmerHighlight = Color(0xFFF5F5F5);

  // Rating star
  static const Color starYellow = Color(0xFFFBBF24);

  // Tag colors
  static const Color tagGreen = Color(0xFFD1FAE5);
  static const Color tagGreenText = Color(0xFF059669);
  static const Color tagBlue = Color(0xFFDBEAFE);
  static const Color tagBlueText = Color(0xFF2563EB);
  static const Color tagPurple = Color(0xFFEDE9FE);
  static const Color tagPurpleText = Color(0xFF7C3AED);
}
