import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

class TripMapPreview extends StatelessWidget {
  final VoidCallback? onExpand;

  const TripMapPreview({super.key, this.onExpand});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: AppColors.softCardShadow,
            blurRadius: 18,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Placeholder for map snapshot
          ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Container(
              color: const Color(0xFFE5E7EB),
              child: const Center(
                child: Icon(Icons.map_outlined, size: 56, color: Colors.black45),
              ),
            ),
          ),
          Positioned(
            right: 14,
            bottom: 14,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: onExpand,
              child: Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.softCardShadow,
                      blurRadius: 14,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(Icons.open_in_full, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

