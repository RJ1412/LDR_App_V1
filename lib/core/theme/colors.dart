import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Core Backgrounds
  static const Color background = Color(0xff0F0D13);      // Deep rich purple-black
  static const Color surface = Color(0xff181424);         // Card background
  static const Color surfaceElevated = Color(0xff221C32); // Dialog / elevated card background

  // Core Brand Colors (Warm & Emotional)
  static const Color primary = Color(0xffFF5E7E);         // Warm coral pink (heart / affection)
  static const Color secondary = Color(0xffA385FF);       // Soft lilac / violet (sync / streaks)
  static const Color accent = Color(0xffFF88A5);          // Brighter highlight pink
  
  // Status Colors
  static const Color success = Color(0xff4ADE80);         // Fresh green (Check-in complete)
  static const Color warning = Color(0xffFBBF24);         // Warm amber (Streak warning)
  static const Color error = Color(0xffF87171);           // Soft red (Error state / stress high)
  static const Color info = Color(0xff60A5FA);            // Soft blue (Analytics info)

  // Sliders / Mood Spectrum Indicators
  static const Color energyHigh = Color(0xffFFE066);       // Sunny yellow
  static const Color stressHigh = Color(0xffF87171);       // Soft red / stress high
  static const Color affectionHigh = Color(0xffFF5E7E);    // Deep pink / warm affection

  // Neutrals / Typography
  static const Color textPrimary = Color(0xffFFFFFF);     // Pure white
  static const Color textSecondary = Color(0xffA69FB6);   // Soft lavender grey
  static const Color textMuted = Color(0xff6C667E);       // Darker neutral for placeholders
  static const Color border = Color(0xff2A233C);          // Subtle borders for premium card edges

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient warmGradient = LinearGradient(
    colors: [primary, Color(0xffFF8F7E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient coolingGradient = LinearGradient(
    colors: [secondary, Color(0xff60A5FA)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient glassGradient = LinearGradient(
    colors: [
      Color(0x1fffffff), // Very thin semi-transparent white
      Color(0x0affffff),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
