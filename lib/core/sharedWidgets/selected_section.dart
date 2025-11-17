import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/app_colors.dart';
import '../utils/app_constants.dart';

class SelectedSection extends StatefulWidget {
  SelectedSection({
    super.key,
    required this.itemName,
    required this.index,
    required this.items,
    this.isDesktop = false,
    required this.selectItem,
  });

  void Function(String, int) selectItem;
  String itemName;
  int index;
  bool isDesktop = false;
  List<String> items;

  @override
  State<SelectedSection> createState() => _SelectItemInListState();
}

class _SelectItemInListState extends State<SelectedSection> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      height: isExpanded ? AppConstants.h * 0.34 : AppConstants.h * 0.07,
      width: widget.isDesktop ? AppConstants.w * 0.95 : AppConstants.w * 0.85,
      decoration: BoxDecoration(
        color: Colors.white,

        border: Border.all(color: Colors.grey.shade300, width: 1.5),
        borderRadius: BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(isExpanded)
              SizedBox(height: AppConstants.h * 0.01),
              buildChooseItem(widget.itemName),
              AnimatedOpacity(
                opacity: isExpanded ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: isExpanded
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppConstants.w * 0.05,
                          vertical: AppConstants.h * 0.01,
                        ),
                        child: Column(
                          children: widget.items
                              .asMap()
                              .entries
                              .map(
                                (entry) => buildItem(
                                  entry.key,
                                  entry.value,
                                  widget.index,
                                ),
                              )
                              .toList(),
                        ),
                      )
                    : const SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildChooseItem(String selectedCompanyName) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: isExpanded?AppConstants.h * 0.02:0,
        horizontal: AppConstants.w * 0.05,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            selectedCompanyName,
            style: TextStyle(
              fontSize: widget.isDesktop
                  ? AppConstants.w * 0.015
                  : AppConstants.w * 0.045,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: AnimatedRotation(
              turns: isExpanded ? 0.5 : 0,
              duration: const Duration(milliseconds: 300),
              child: Icon(
                isExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w600,
                size: widget.isDesktop
                    ? AppConstants.w * 0.03
                    : AppConstants.w * 0.07,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem(int index, String itemName, int selectedIndex) {
    final bool isSelected = index == selectedIndex;

    return GestureDetector(
      onTap: () {
        widget.selectItem(itemName, index);

        Future.delayed(Duration(milliseconds: 400), () {
          setState(() {
            isExpanded = !isExpanded;
          });
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: AppConstants.h * 0.01),
        height: widget.isDesktop
            ? AppConstants.h * 0.06
            : AppConstants.h * 0.05,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(AppConstants.w * 0.03),
          border: Border.all(color: AppColors.primaryColor, width: 2),
        ),
        alignment: Alignment.center,
        child: Text(
          itemName,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.primaryColor,
            fontWeight: FontWeight.w500,
            fontSize: widget.isDesktop
                ? AppConstants.w * 0.012
                : AppConstants.w * 0.04,
          ),
        ),
      ),
    );
  }
}
