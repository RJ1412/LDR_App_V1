import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTypography {
  AppTypography._();

  // Primary Font Family: Outfit (Premium rounded geometric - perfect for warm emotional connection)
  static TextStyle get _baseHeadingStyle => GoogleFonts.outfit(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.bold,
      );

  // Secondary Font Family: Inter (Highly legible, crisp - ideal for UI labels and long-form check-ins)
  static TextStyle get _baseBodyStyle => GoogleFonts.inter(
        color: AppColors.textPrimary,
      );

  // --- Headings ---
  static TextStyle get h1 => _baseHeadingStyle.copyWith(
        fontSize: 32,
        letterSpacing: -0.5,
        fontWeight: FontWeight.w800,
      );

  static TextStyle get h2 => _baseHeadingStyle.copyWith(
        fontSize: 24,
        letterSpacing: -0.3,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get h3 => _baseHeadingStyle.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get subtitle => _baseHeadingStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      );

  // --- Body Copy ---
  static TextStyle get bodyLarge => _baseBodyStyle.copyWith(
        fontSize: 16,
        height: 1.5,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get bodyMedium => _baseBodyStyle.copyWith(
        fontSize: 14,
        height: 1.4,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get bodySmall => _baseBodyStyle.copyWith(
        fontSize: 12,
        height: 1.3,
        color: AppColors.textSecondary,
      );

  // --- UI Elements ---
  static TextStyle get buttonText => _baseHeadingStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      );

  static TextStyle get labelText => _baseBodyStyle.copyWith(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        color: AppColors.textSecondary,
      );

  static TextStyle get cardTitle => _baseHeadingStyle.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get statsNumber => _baseHeadingStyle.copyWith(
        fontSize: 48,
        fontWeight: FontWeight.w900,
        letterSpacing: -1.0,
      );
}
