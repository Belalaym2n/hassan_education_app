import 'package:amr_rezk_education/features/lectures/presentation/bloc/get_lectures_bloc.dart';
import 'package:amr_rezk_education/features/lectures/presentation/bloc/get_lectures_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_constants.dart';

class TabsSelectorItem extends StatefulWidget {
  const TabsSelectorItem({super.key});

  @override
  State<TabsSelectorItem> createState() => _TabsSelectorItemState();
}

class _TabsSelectorItemState extends State<TabsSelectorItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTab(index: 0, label: "المحاضرات", icon: Icons.menu_book_rounded),
        SizedBox(width: AppConstants.w * 0.03),
        _buildTab(
          index: 1,
          label: "قوائم التشغيل",
          icon: Icons.playlist_play_rounded,
        ),
      ],
    );
  }

  Widget _buildTab({
    required int index,
    required String label,
    required IconData icon,
  }) {
    final bool isSelected =
        context.watch<GetLecturesBloc>().selectedIndex == index;

     return GestureDetector(
      onTap: () => {
        print("change index"),
         context.read<GetLecturesBloc>().add(ChangeTapEvent(index))},
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOut,
        padding: EdgeInsets.symmetric(
          vertical: AppConstants.h * 0.018,
          horizontal: AppConstants.w * 0.06,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : AppColors.cardColor,
          borderRadius: BorderRadius.circular(AppConstants.w * 0.04),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primaryColor.withOpacity(0.35),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
          border: Border.all(
            color: isSelected ? Colors.transparent : AppColors.lightBlack,
            width: 1.2,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : AppColors.textSecondary,
              size: AppConstants.w * 0.06,
            ),
            SizedBox(width: AppConstants.w * 0.02),
            Text(
              label,
              style: TextStyle(
                fontSize: AppConstants.w * 0.04,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
