import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/login_controller.dart';
import '../core/app_colors.dart';
import '../core/app_texts.dart';
import '../core/app_theme.dart';
import '../routes/app_routes.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    // Single navigation after delay: Home if logged in, else Login (avoids double Home)
    Future.delayed(const Duration(seconds: 2), () {
      if (Get.isRegistered<LoginController>() &&
          Get.find<LoginController>().isAuthenticated) {
        Get.offAllNamed(AppRoutes.home);
      } else {
        Get.offNamed(AppRoutes.login);
      }
    });

    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.directions_car,
              size: 96,
              color: AppColors.portalOlive,
            ),
            const SizedBox(height: 16),
            Text(
              AppTexts.limoGuy,
              style: AppTheme.splashTitle,
            ),
            const SizedBox(height: 24),
            Shimmer.fromColors(
              baseColor: AppColors.portalOlive.withOpacity(0.3),
              highlightColor: AppColors.portalOlive,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.portalOlive,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

