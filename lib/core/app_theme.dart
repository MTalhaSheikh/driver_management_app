import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.portalOlive,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppColors.screenBackground,
      textTheme: _textTheme,
    );
  }

  static const TextTheme _textTheme = TextTheme(
    // Display styles
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w900,
      color: AppColors.textPrimary,
      letterSpacing: -0.5,
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w800,
      color: AppColors.textPrimary,
      letterSpacing: -0.5,
    ),
    displaySmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w800,
      color: AppColors.textPrimary,
    ),

    // Headline styles
    headlineLarge: TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w800,
      color: AppColors.textPrimary,
    ),
    headlineMedium: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w900,
      color: AppColors.textPrimary,
    ),
    headlineSmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w800,
      color: AppColors.textPrimary,
    ),

    // Title styles
    titleLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w800,
      color: AppColors.textPrimary,
    ),
    titleMedium: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w800,
      color: AppColors.textPrimary,
    ),
    titleSmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
    ),

    // Body styles
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppColors.textSecondary,
    ),
    bodySmall: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: AppColors.textSecondary,
    ),

    // Label styles
    labelLarge: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
    ),
    labelMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
    ),
    labelSmall: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
    ),
  );

  // Base reusable styles
  static const TextStyle _base13w800Primary = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );

  static const TextStyle _base13w700Primary = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const TextStyle _base13w700Secondary = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: AppColors.textSecondary,
  );

  static const TextStyle _base15w700Secondary = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.textSecondary,
  );

  // Custom text styles for specific use cases (reusing base styles)
  static const TextStyle splashTitle = TextStyle(
    fontSize: 22,
        fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
      );

  static const TextStyle welcomeSubtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
  );

  static const TextStyle driverName = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w900,
    color: AppColors.textPrimary,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w900,
    color: AppColors.textPrimary,
  );

  static const TextStyle dateLabel = TextStyle(
    fontSize: 14,
        fontWeight: FontWeight.w700,
    color: AppColors.textSecondary,
      );

  static const TextStyle tripTime = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );

  static const TextStyle locationTitle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );

  static const TextStyle locationSubtitle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static const TextStyle locationLabel = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.2,
    color: AppColors.textSecondary,
  );

  static const TextStyle passengerName = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w800,
    color: Colors.white,
  );

  static const TextStyle buttonTextSecondary = _base13w800Primary;

  static const TextStyle statusPill = _base13w800Primary;

  static const TextStyle metaText = _base13w700Secondary;

  static const TextStyle segmentedSwitch = _base15w700Secondary;

  static const TextStyle segmentedSwitchSelected = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static const TextStyle filterTab = _base13w700Primary;

  static const TextStyle loginTitle = TextStyle(
    fontSize: 26,
        fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
      );

  static const TextStyle loginSubtitle = TextStyle(
    fontSize: 14,
        fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
      );

  static const TextStyle fieldHint = TextStyle(
    color: Colors.grey,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle errorText = TextStyle(
    color: Colors.red,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
}
