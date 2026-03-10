import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Pastel / medical minimalist palette
  static const Color primary = Color(0xFF5CA3FF); // Soft blue
  static const Color primaryLight = Color(0xFFD3E8FF);
  
  static const Color success = Color(0xFF75CEA6); // Mint green
  static const Color successLight = Color(0xFFE2F5EC);

  static const Color warning = Color(0xFFFFB672); // Soft orange
  static const Color warningLight = Color(0xFFFFF2E6);

  static const Color critical = Color(0xFFFF7E80); // Muted red
  static const Color criticalLight = Color(0xFFFFE8E8);

  static const Color highlight = Color(0xFFFFDB72); // Warm yellow
  static const Color highlightLight = Color(0xFFFFF7E0);

  static const Color background = Color(0xFFF7F9FC); // Light grey/off-white
  static const Color surface = Colors.white;
  
  static const Color textMain = Color(0xFF2D3748);
  static const Color textLight = Color(0xFF718096);
  static const Color border = Color(0xFFE2E8F0);
}

class AppTheme {
  static ThemeData get lightTheme {
    final baseTextTheme = GoogleFonts.quicksandTextTheme();

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        background: AppColors.background,
        surface: AppColors.surface,
        error: AppColors.critical,
      ),
      scaffoldBackgroundColor: AppColors.background,
      
      // Typography
      textTheme: baseTextTheme.copyWith(
        displayLarge: baseTextTheme.displayLarge?.copyWith(fontWeight: FontWeight.bold, color: AppColors.textMain),
        headlineMedium: baseTextTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700, color: AppColors.textMain),
        titleLarge: baseTextTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600, color: AppColors.textMain),
        bodyLarge: baseTextTheme.bodyLarge?.copyWith(color: AppColors.textMain),
        bodyMedium: baseTextTheme.bodyMedium?.copyWith(color: AppColors.textLight),
      ),

      // Card Theme (Soft shadows, rounded corners)
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.05),
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
      ),

      // Elevated Button (Large rounded action button)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.textMain,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          textStyle: GoogleFonts.quicksand(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      
      // Bottom Navigation
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textLight,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 20,
      ),
    );
  }
}
