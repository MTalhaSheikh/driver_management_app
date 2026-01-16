import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    final splineSansFont = GoogleFonts.splineSans();
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.portalOlive,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppColors.screenBackground,
      fontFamily: splineSansFont.fontFamily,
      textTheme: _textTheme,
    );
  }

  static TextTheme get _textTheme {
    return TextTheme(
      // Display styles
      displayLarge: GoogleFonts.splineSans(
        fontSize: 32,
        fontWeight: FontWeight.w900,
        color: AppColors.textPrimary,
        letterSpacing: -0.5,
      ),
      displayMedium: GoogleFonts.splineSans(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
        letterSpacing: -0.5,
      ),
      displaySmall: GoogleFonts.splineSans(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
      ),

      // Headline styles
      headlineLarge: GoogleFonts.splineSans(
        fontSize: 26,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
      ),
      headlineMedium: GoogleFonts.splineSans(
        fontSize: 22,
        fontWeight: FontWeight.w900,
        color: AppColors.textPrimary,
      ),
      headlineSmall: GoogleFonts.splineSans(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
      ),

      // Title styles
      titleLarge: GoogleFonts.splineSans(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
      ),
      titleMedium: GoogleFonts.splineSans(
        fontSize: 17,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
      ),
      titleSmall: GoogleFonts.splineSans(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),

      // Body styles
      bodyLarge: GoogleFonts.splineSans(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      bodyMedium: GoogleFonts.splineSans(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
      ),
      bodySmall: GoogleFonts.splineSans(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
      ),

      // Label styles
      labelLarge: GoogleFonts.splineSans(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
      labelMedium: GoogleFonts.splineSans(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
      labelSmall: GoogleFonts.splineSans(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
    );
  }

  // Base reusable styles
  static TextStyle get _base13w800Primary => GoogleFonts.splineSans(
    fontSize: 13,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );

  static TextStyle get _base13w700Primary => GoogleFonts.splineSans(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle get _base13w700Secondary => GoogleFonts.splineSans(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: AppColors.textSecondary,
  );

  static TextStyle get _base15w700Secondary => GoogleFonts.splineSans(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.textSecondary,
  );

  // Custom text styles for specific use cases (reusing base styles)
  static TextStyle get splashTitle => GoogleFonts.splineSans(
    fontSize: 22,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );

  static TextStyle get welcomeSubtitle => GoogleFonts.splineSans(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
  );

  static TextStyle get driverName => GoogleFonts.splineSans(
    fontSize: 22,
    fontWeight: FontWeight.w900,
    color: AppColors.textPrimary,
  );

  static TextStyle get sectionTitle => GoogleFonts.splineSans(
    fontSize: 22,
    fontWeight: FontWeight.w900,
    color: AppColors.textPrimary,
  );

  static TextStyle get dateLabel => GoogleFonts.splineSans(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.textSecondary,
  );

  static TextStyle get tripTime => GoogleFonts.splineSans(
    fontSize: 26,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );

  static TextStyle get locationTitle => GoogleFonts.splineSans(
    fontSize: 17,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );

  static TextStyle get locationSubtitle => GoogleFonts.splineSans(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static TextStyle get locationLabel => GoogleFonts.splineSans(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.2,
    color: AppColors.textSecondary,
  );

  static TextStyle get passengerName => GoogleFonts.splineSans(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
  );

  static TextStyle get buttonText => GoogleFonts.splineSans(
    fontSize: 13,
    fontWeight: FontWeight.w800,
    color: Colors.white,
  );

  static TextStyle get buttonTextSecondary => _base13w800Primary;

  static TextStyle get statusPill => _base13w800Primary;

  static TextStyle get metaText => _base13w700Secondary;

  static TextStyle get segmentedSwitch => _base15w700Secondary;

  static TextStyle get segmentedSwitchSelected => GoogleFonts.splineSans(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static TextStyle get filterTab => _base13w700Primary;

  static TextStyle get loginTitle => GoogleFonts.splineSans(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle get loginSubtitle => GoogleFonts.splineSans(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  static TextStyle get fieldHint => GoogleFonts.splineSans(
    color: Colors.grey,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get errorText => GoogleFonts.splineSans(
    color: Colors.red,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  // Additional text styles for profile and other views
  static TextStyle get bodyMedium => GoogleFonts.splineSans(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
  );

  static TextStyle get titleMedium => GoogleFonts.splineSans(
    fontSize: 17,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );
}
