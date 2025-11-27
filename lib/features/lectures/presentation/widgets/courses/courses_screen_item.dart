import 'package:amr_rezk_education/features/lectures/data/models/play_list_model.dart';
import 'package:amr_rezk_education/features/lectures/presentation/pages/month_content_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../../dashboard/addLecture/data/models/lecture_model.dart';
import '../common/nullable.dart';
import '../lecture/lecture_screen_item.dart';
import 'course_item.dart';

class CoursesScreenItem extends StatefulWidget {
  CoursesScreenItem({
    super.key,
    this.isPlayList = false,
    required this.lectures,
    required this.playLists,
    required this.navigator,
  });
  final Function(String,String) navigator;

  List<LectureModel> lectures;
  List<PlaylistModel> playLists;
  bool isPlayList;

  @override
  State<CoursesScreenItem> createState() => _CoursesScreenItemState();
}

class _CoursesScreenItemState extends State<CoursesScreenItem> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.primaryColor,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      body: widget.lectures.isEmpty && widget.isPlayList == false
          ? nullableWidget()
          : widget.playLists.isEmpty && widget.isPlayList == true
          ? nullableWidget()
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: AppConstants.h * 0.02),
                  ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,

                    // ← ده اللي مخليهم جنب بعض
                    itemCount: widget.isPlayList
                        ? widget.playLists.length
                        : widget.lectures.length,
                    itemBuilder: (context, index) {
                      return CourseItem(
                        isPlayList: widget.isPlayList,

                        navigator: () {
                          !widget.isPlayList
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => LectureScreenItem(
                                      lectureModel: widget.lectures[index],
                                    ),
                                  ),
                                )
                              :        widget.navigator(widget.playLists[index].name,widget.playLists[index].id);

                        },
                        playListModel:
                            widget.isPlayList && widget.playLists.isNotEmpty
                            ? widget.playLists[index]
                            : null,
                        lectureModel:
                            !widget.isPlayList && widget.lectures.isNotEmpty
                            ? widget.lectures[index]
                            : null,
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
