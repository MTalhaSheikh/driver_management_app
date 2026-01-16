import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/app_colors.dart';

/// Reusable shimmer loading widget for map preview
class ShimmerMapPreview extends StatelessWidget {
  final double height;
  final double borderRadius;

  const ShimmerMapPreview({
    super.key,
    this.height = 190,
    this.borderRadius = 22,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: const [
          BoxShadow(
            color: AppColors.softCardShadow,
            blurRadius: 18,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Shimmer.fromColors(
          baseColor: const Color(0xFFE5E7EB),
          highlightColor: Colors.white,
          child: Container(
            color: const Color(0xFFE5E7EB),
          ),
        ),
      ),
    );
  }
}

/// Shimmer loading for full screen map
class ShimmerFullScreenMap extends StatelessWidget {
  const ShimmerFullScreenMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFE5E7EB),
      highlightColor: Colors.white,
      child: Container(
        color: const Color(0xFFE5E7EB),
      ),
    );
  }
}

/// Shimmer loading for card content
class ShimmerCard extends StatelessWidget {
  final double? width;
  final double height;
  final double borderRadius;

  const ShimmerCard({
    super.key,
    this.width,
    this.height = 100,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFE5E7EB),
      highlightColor: Colors.white,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: const Color(0xFFE5E7EB),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

/// Shimmer loading for text lines
class ShimmerTextLine extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const ShimmerTextLine({
    super.key,
    this.width = double.infinity,
    this.height = 16,
    this.borderRadius = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFE5E7EB),
      highlightColor: Colors.white,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: const Color(0xFFE5E7EB),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

/// Shimmer loading for circular avatar
class ShimmerAvatar extends StatelessWidget {
  final double radius;

  const ShimmerAvatar({
    super.key,
    this.radius = 30,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFE5E7EB),
      highlightColor: Colors.white,
      child: Container(
        width: radius * 2,
        height: radius * 2,
        decoration: const BoxDecoration(
          color: Color(0xFFE5E7EB),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

/// Shimmer loading for button
class ShimmerButton extends StatelessWidget {
  final double? width;
  final double height;
  final double borderRadius;

  const ShimmerButton({
    super.key,
    this.width,
    this.height = 50,
    this.borderRadius = 22,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFE5E7EB),
      highlightColor: Colors.white,
      child: Container(
        width: width ?? double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: const Color(0xFFE5E7EB),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
