import 'package:amr_rezk_education/core/intialization/init_di.dart';
import 'package:amr_rezk_education/features/lectures/presentation/bloc/get_lectures_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/sharedWidgets/app_snack_bar.dart';
import '../../../../core/sharedWidgets/top_screen_widget.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../dashboard/addLecture/data/models/lecture_model.dart';
import '../../domain/use_cases/get_lectures_use_case.dart';
import '../bloc/get_lectures_bloc.dart';
import '../bloc/get_lectures_events.dart';
import '../widgets/courses/courses_screen_item.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  late GetLecturesBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = GetLecturesBloc(getIt<GetLecturesUseCase>())
      ..add(LoadLecturesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
          body:    Column(
          children: [
          TopScreenWidget(text: "الدورات التعليمية"),
              SizedBox(height: AppConstants.h * 0.01),
                BlocProvider.value(
                value: _bloc,
                child: BlocListener<GetLecturesBloc, GetLecturesState>(
                  listener: (context, state) {
          if (state is GetLecturesError) {
            AppSnackBar.showError(context, state.message);
          }
                  },
                  child: BlocBuilder<GetLecturesBloc, GetLecturesState>(
          builder: (context, state) {

            if (state is GetLecturesLoaded) {
              return Expanded(     //  ← ← ← هنا الحل
                child: state.lectures.isEmpty
                    ? nullableWidget()
                    : CoursesScreenItem(lectures: state.lectures),
              );
            } else if (state is GetLecturesLoading) {
              return showApartmentLoading();
            }
            return const SizedBox();
          },
                  ),
                ),)])
    );
  }

  List<LectureModel> fakeLectures = [
    LectureModel(
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

  showApartmentLoading() {
    return Skeletonizer(child: CoursesScreenItem(lectures: fakeLectures));
  }

  nullableWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.home_outlined,
            size: AppConstants.w * 0.25,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            "No apartments available",
            style: TextStyle(
              fontSize: AppConstants.w * 0.05,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            "Check back later or try refreshing the page.",
            style: TextStyle(
              fontSize: AppConstants.w * 0.04,
              color: Colors.grey.shade500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
