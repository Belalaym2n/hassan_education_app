import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../../dashboard/addLecture/data/models/lecture_model.dart';
import 'course_item.dart';

class CoursesScreenItem extends StatefulWidget {
  CoursesScreenItem({super.key, required this.lectures});

  List<LectureModel> lectures;

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

    return    ListView.builder(

      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,   // ← ده اللي مخليهم جنب بعض

      itemCount: widget.lectures.length,
       itemBuilder: (context, index) {
        return  CourseItem(lectureModel: widget.lectures[index]);
      },
    );
  }
}
