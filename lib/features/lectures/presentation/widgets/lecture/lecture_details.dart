import 'package:amr_rezk_education/features/dashboard/addLecture/data/models/lecture_model.dart';
import 'package:amr_rezk_education/core/utils/app_colors.dart';
import 'package:amr_rezk_education/core/utils/app_constants.dart';
import 'package:flutter/material.dart';

class VideoDetailsScreen extends StatefulWidget {
  final LectureModel lectureModel;

  const VideoDetailsScreen({required this.lectureModel});

  @override
  State<VideoDetailsScreen> createState() => _VideoDetailsScreenState();
}

class _VideoDetailsScreenState extends State<VideoDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    AppConstants.initSize(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end ,
      children: [

 
        // 🟡 Headline
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            widget.lectureModel.name,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              height: 1.3,
            ),
          ),
        ),

        const SizedBox(height: 12),

        // 📄 Description Card
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  spreadRadius: 1,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Text(
              widget.lectureModel.description,
              style: TextStyle(
                fontSize: 16,
                height: 1.6,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ),

        const SizedBox(height: 25),




      ],
    );
  }


}
