import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_constants.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final bool isMobile;
  final VoidCallback onTap;

  const MenuItem({
    super.key,
    required this.title,
    required this.isMobile,
    required this.icon,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final w = AppConstants.w;
    final h = AppConstants.h;

    final borderRadius = BorderRadius.circular(w * 0.0444); // 16 / 360
    final iconSize = w * 0.0555; // 20 / 360

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: w * 0.0333, // 12 / 360
        vertical: h * 0.00515,  // 4 / 776
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onTap,
          splashColor: AppColors.primaryColor.withOpacity(0.2),
          highlightColor: Colors.transparent,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            padding: EdgeInsets.symmetric(
              horizontal: w * 0.0222, // 8 / 360
              vertical: h * 0.0206,   // 16 / 776
            ),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primaryColor : Colors.transparent,
              borderRadius: borderRadius,
              boxShadow: isSelected
                  ? [
                BoxShadow(
                  color: AppColors.primaryColor.withOpacity(0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ]
                  : [],
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(w * 0.0222), // 8 / 360
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(w * 0.0333), // 12 / 360
                  ),
                  child: Icon(
                    icon,
                    size: iconSize,
                    color: isSelected
                        ? AppColors.primaryColor
                        : colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(width: w * 0.0166), // 6 / 360
                Expanded(
                  child: Text(
                    title,
                    style: textTheme.titleMedium?.copyWith(
                      fontSize: w * 0.038, // ~14–15 on common widths
                      color: isSelected
                          ? Colors.white
                          : colorScheme.onSurface,
                      fontWeight:
                      isSelected ? FontWeight.w600 : FontWeight.w400,
                      letterSpacing: 0.2,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (isSelected) ...[
                  SizedBox(width: w * 0.0444), // 16 / 360
                  Container(
                    width: w * 0.0277, // 10 / 360
                    height: w * 0.0277,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
