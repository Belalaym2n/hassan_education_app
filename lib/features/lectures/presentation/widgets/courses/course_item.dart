import 'package:amr_rezk_education/core/utils/app_colors.dart';
import 'package:amr_rezk_education/core/utils/app_constants.dart';
import 'package:amr_rezk_education/core/utils/app_images.dart';
import 'package:amr_rezk_education/features/dashboard/addLecture/data/models/lecture_model.dart';
import 'package:amr_rezk_education/features/lectures/presentation/widgets/lecture/video_lecture.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../pages/month_content_screen.dart';
import '../lecture/lecture_screen_item.dart';

class CourseItem extends StatefulWidget {
  CourseItem({super.key, required this.lectureModel});

  LectureModel lectureModel;

  @override
  State<CourseItem> createState() => _CourseItemState();
}

class _CourseItemState extends State<CourseItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.w * 0.06,
        vertical: AppConstants.h * 0.01,
      ),
      child: Container(
        width: AppConstants.w * 0.87,

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppConstants.w * 0.04),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildImageWithPlayIcon(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildHeadline(),

                  _buildDescription(),
                  const SizedBox(height: 8),
                  _buildBooking(),
                  const SizedBox(height: 6),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getYoutubeThumbnail(String url) {
    final Uri? uri = Uri.tryParse(url);

    if (uri == null) return "";

    String? videoId;

    // روابط YouTube الرسمية
    if (uri.queryParameters.containsKey('v')) {
      videoId = uri.queryParameters['v'];
    }
    // روابط short
    else if (uri.host.contains('youtu.be')) {
      videoId = uri.pathSegments.isNotEmpty ? uri.pathSegments[0] : null;
    }

    if (videoId == null) return "";

    return "https://img.youtube.com/vi/$videoId/hqdefault.jpg";
  }

  Widget _buildImageWithPlayIcon() {
    final thumbnailUrl = getYoutubeThumbnail(widget.lectureModel.videoUrl);

    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(AppConstants.w * 0.04),
        topLeft: Radius.circular(AppConstants.w * 0.04),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // الصورة من YouTube
          Image.network(
            thumbnailUrl,
            width: AppConstants.w * 0.87,
            height: AppConstants.h * 0.18,
            fit: BoxFit.fitWidth,
            errorBuilder: (_, __, ___) {
              return Image.asset(
                AppImages.courseImage,
                width: AppConstants.w * 0.84,
                height: AppConstants.h * 0.18,
                fit: BoxFit.fitWidth,
              );
            },
          ),

          // طبقة شفافة
          Container(
            width: double.infinity,
            height: AppConstants.h * 0.18,
            color: AppColors.primaryColor.withOpacity(0.35),
          ),

          // زر Play
          InkWell(
            onTap: () {
              print("Open Video: ${widget.lectureModel.videoUrl}");
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(AppConstants.w * 0.025),
              child: Icon(
                Icons.play_arrow_rounded,
                color: AppColors.primaryColor,
                size: AppConstants.w * 0.09,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeadline() {
    return Text(
      widget.lectureModel.name,
      textAlign: TextAlign.end,
      style: TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: AppConstants.w * 0.053,
        color: AppColors.primaryColor,
      ),
    );
  }

  Widget _buildDescription() {
    return Text(
      widget.lectureModel.description,
      textAlign: TextAlign.end,
      style: TextStyle(
        fontSize: AppConstants.w * 0.037,
        fontWeight: FontWeight.w500,
        color: Colors.grey[700],
        height: 1.6,
      ),
    );
  }

  Widget _buildBooking() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_buildButton(), _buildPriceText()],
    );
  }

  Widget _buildPriceText() {
    return Text(
      "224 EGP",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: AppConstants.w * 0.05,
        color: Colors.black87,
      ),
    );
  }


  Widget _buildButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: AppConstants.w * 0.05,
          vertical: AppConstants.h * 0.012,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.w * 0.03),
        ),
        elevation: 0,
      ),
      onPressed: () {


          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => LectureScreenItem(lectureModel: widget.lectureModel),
            ),
          );
        },



      child: Text(
        "ابدأ الآن",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: AppConstants.w * 0.038,
        ),
      ),
    );
  }
}
