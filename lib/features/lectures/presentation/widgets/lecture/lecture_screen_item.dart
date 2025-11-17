import 'package:amr_rezk_education/core/utils/app_colors.dart';
import 'package:amr_rezk_education/core/utils/app_constants.dart';
import 'package:amr_rezk_education/features/dashboard/addLecture/data/models/lecture_model.dart';
import 'package:amr_rezk_education/features/lectures/presentation/widgets/lecture/video_lecture.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../../../../core/sharedWidgets/top_screen_widget.dart';
import 'lecture_details.dart';

class LectureScreenItem extends StatefulWidget {
    LectureScreenItem({super.key,required this.lectureModel});
LectureModel lectureModel;
  @override
  State<LectureScreenItem> createState() => _LectureScreenItemState();
}

class _LectureScreenItemState extends State<LectureScreenItem> {
  @override
  Widget build(BuildContext context) {
    final videoId = extractYoutubeId(widget.lectureModel.videoUrl);

    return  SafeArea(child: Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back,color: Colors.white,),
        backgroundColor: AppColors.primaryColor,
        title: Text(widget.lectureModel.name,style: TextStyle(
          color: Colors.white
        ),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            SizedBox(
              height: AppConstants.h/2,
              child: PlayerScreen(
                videoId: videoId,

              ),
            ),
            VideoDetailsScreen(
              lectureModel: widget.lectureModel,
            )
          ],
        ),
      ),
    ));
  }

  String extractYoutubeId(String url) {
    return YoutubePlayerController.convertUrlToId(url) ?? "";
  }
}
