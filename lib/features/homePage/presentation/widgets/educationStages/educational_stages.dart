import 'package:amr_rezk_education/core/utils/app_constants.dart';
import 'package:amr_rezk_education/features/homePage/presentation/widgets/educationStages/stageItem.dart';
import 'package:flutter/material.dart';
import 'package:amr_rezk_education/core/utils/app_colors.dart';
import 'package:amr_rezk_education/features/homePage/presentation/widgets/educationStages/stages_model.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../../core/sharedWidgets/sectionName.dart';
import '../whyChooseTeacher/whyChooseAmr.dart';

class EducationalStages extends StatelessWidget {
  const EducationalStages({super.key});

  @override
  Widget build(BuildContext context) {
    return
          Column(
            children: [
              WhyChooseTeacher(
                name: 'مراحل التعليم',
              ),
              SizedBox(
                height:AppConstants.h*0.43,

                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: stages.length,
                  itemBuilder: (context, index) {
                    final stage = stages[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        left: AppConstants.w * 0.0333,   // 12 / 360
                        bottom: AppConstants.w * 0.0333, // 12 / 360
                      ),


                    child: AnimatedStageCard(stage: stage, index: index),
                    );
                  },
                ),


                  ),
            ],
          );
  }
}
