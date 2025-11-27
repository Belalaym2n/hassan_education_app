import 'package:amr_rezk_education/features/lectures/presentation/widgets/tabs/taps_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:amr_rezk_education/core/intialization/init_di.dart';
import 'package:amr_rezk_education/features/lectures/domain/use_cases/get_all_play_lists.dart';
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
import '../widgets/lecture/lecture_screen_item.dart';
import 'month_content_screen.dart';

class TabsSelectedScreen extends StatefulWidget {
  const TabsSelectedScreen({super.key});

  @override
  State<TabsSelectedScreen> createState() => _TabsSelectedScreenState();
}

class _TabsSelectedScreenState extends State<TabsSelectedScreen> {
  late GetLecturesBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = GetLecturesBloc(
      getIt<GetLecturesUseCase>(),
      getIt<GetPlaylistsUseCase>(),
    )..add(LoadLecturesEvent());
  }

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        body: Column(
          children: [
            TopScreenWidget(text: "الدورات التعليمية"),
            SizedBox(height: AppConstants.h * 0.01),

            TabsSelectorItem(),

            BlocListener<GetLecturesBloc, GetLecturesState>(
              listener: (context, state) {
                if (state is GetLecturesError) {
                  AppSnackBar.showError(context, state.message);
                }
              },
              child: BlocBuilder<GetLecturesBloc, GetLecturesState>(
                builder: (context, state) {
                  if (state is ChangeTapSuccess) {
                    return state.index == 0
                        ? Expanded(
                            //  ← ← ← هنا الحل
                            child: CoursesScreenItem(
                              navigator: (String name,String id){},

                              playLists: [],
                              lectures: state.lectures,
                            ),
                          )
                        : Expanded(
                             child: CoursesScreenItem(
                               navigator: (String name,String id){
                                 Navigator.push(
                                   context,
                                   MaterialPageRoute(
                                     builder: (_) => BlocProvider.value(
                                       value: _bloc..add(GetLecturesOnPlaylistsEvent(id)),      // نفس البلوك من الشاشة الرئيسية
                                       child: MonthContentScreen(
                                         playListName: name,
                                         playListID: id,
                                       ),
                                     ),
                                   ),
                                 );
                               },
                               lectures: state.lectures,
                              isPlayList: true,
                              playLists: state.playLists,
                            ),
                          );
                  }
                  if (state is GetLecturesLoaded) {
                    return Expanded(

                      //  ← ← ← هنا الحل
                      child: CoursesScreenItem(
                        navigator: (String name,String id){},

                        isPlayList: false,
                        playLists: [],
                        lectures: state.lectures,
                      ),
                    );
                  }
                  if (state is PlaylistLoaded) {
                    return Expanded(
                      //  ← ← ← هنا الحل
                      child: CoursesScreenItem(
                        navigator: (String name,String id){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: _bloc..add(GetLecturesOnPlaylistsEvent(id)),      // نفس البلوك من الشاشة الرئيسية
                                child: MonthContentScreen(
                                  playListName: name,
                                  playListID: id,
                                ),
                              ),
                            ),
                          );

                        },
                        isPlayList: true,
                        playLists: state.playlists,
                        lectures: [],
                      ),
                    );
                  } else if (state is GetLecturesLoading ||
                      state is PlaylistLoading) {
                    return Expanded(
                      //  ← ← ← هنا الحل
                      child: showApartmentLoading(),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
            SizedBox(height: AppConstants.h * 0.01),
          ],
        ),
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

  showApartmentLoading() {
    return Skeletonizer(
      child: CoursesScreenItem(
        navigator: (String name,String id){},
        playLists: [],
        isPlayList: false,
        lectures: fakeLectures,
      ),
    );
  }
}
