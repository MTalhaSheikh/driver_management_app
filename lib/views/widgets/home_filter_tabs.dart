import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_theme.dart';

class HomeFilterTabs extends StatelessWidget {
  final List<String> items;
  final String selected;
  final ValueChanged<String> onChanged;

  const HomeFilterTabs({
    super.key,
    required this.items,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: items.map((label) {
        final isSelected = label == selected;
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => onChanged(label),
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.chipSelectedDark
                    : AppColors.chipUnselected,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: isSelected ? Colors.transparent : AppColors.chipBorder,
                ),
                boxShadow: isSelected
                    ? const []
                    : const [
                        BoxShadow(
                          color: AppColors.pillShadow,
                          blurRadius: 14,
                          offset: Offset(0, 8),
                        ),
                      ],
              ),
              child: Text(
                label,
                style: isSelected
                    ? AppTheme.filterTab.copyWith(color: Colors.white)
                    : AppTheme.filterTab,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

