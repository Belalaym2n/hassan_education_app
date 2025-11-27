import 'package:amr_rezk_education/core/sharedWidgets/top_screen_widget.dart';
import 'package:amr_rezk_education/features/dashboard/addLecture/data/models/lecture_model.dart';
import 'package:amr_rezk_education/features/lectures/presentation/bloc/get_lectures_events.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/sharedWidgets/app_snack_bar.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../bloc/get_lectures_bloc.dart';
import '../bloc/get_lectures_states.dart';
import '../widgets/monthContent/month_content_item.dart';
import '../widgets/monthContent/promo_code.dart';

class MonthContentScreen extends StatefulWidget {
  MonthContentScreen({super.key,
    required this.playListID,
    required this.playListName});

  String playListName;
  String playListID;

  @override
  State<MonthContentScreen> createState() => _MonthContentScreenState();
}

class _MonthContentScreenState extends State<MonthContentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: AppConstants.h * 0.04),

          TopScreenWidget(text: " ${widget.playListName}"),
          Expanded(
            child: BlocBuilder<GetLecturesBloc, GetLecturesState>(
              builder: (context, state) {
                if (state is LectureOnPlaylistLoading) {
                  return _show_loading();
                }

                if (state is LectureOnPlaylistLoaded) {
                  return  Column(
                      children: [
                        ContentScreen(lectures: state.lectures),
                        PromoCode(),
                        SizedBox(height: AppConstants.h * 0.02),
                      ],

                  );
                }

                return SizedBox();
              },
            ),
          )
        ],
      ),
    );
  }

  List<LectureModel> fakeLectures = [
    LectureModel(
      price: "234",
      duration: 'sf',

      id: "lec_001",
      name: "Introduction to Flutter",
      description: "Basic introduction to Flutter widgets and structure.",
      videoUrl: "https://www.youtube.com/watch?v=VPvVD8t02U8",
      stage: "الصف الخامس الابتدائي",
      isPlayList: false,
      createdAt: Timestamp.now(),
    ),
    LectureModel(
      price: "234",

      duration: 'sf',
      id: "lec_002",
      name: "Understanding Dart Language",
      description: "Learn variables, functions, OOP in Dart.",
      videoUrl: "https://www.youtube.com/watch?v=Ej_Pcr4uC2Q",
      stage: "الصف الرابع الابتدائي",
      isPlayList: false,
      createdAt: Timestamp.now(),
    ),
  ];

  _show_loading() {
    return Skeletonizer(child: ContentScreen(lectures: fakeLectures));
  }
}
