import 'package:amr_rezk_education/config/routes/app_router.dart';
import 'package:amr_rezk_education/core/sharedWidgets/buttons.dart';
import 'package:amr_rezk_education/core/sharedWidgets/custom_loading.dart';
import 'package:amr_rezk_education/features/lectures/data/models/play_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/sharedWidgets/app_snack_bar.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_constants.dart';
import '../../../../../../core/utils/custom_admin_buttons.dart';
import '../../bloc/playListBloc/play_list_bloc.dart';
import '../../bloc/playListBloc/play_list_events.dart';
import '../../bloc/playListBloc/play_list_states.dart';
import '../../widgets/play_list_lectures/add_lecture_on_play_list.dart';
import '../../widgets/play_list_lectures/lectures_item.dart';
import '../../widgets/questionOfLectureType/lectures_type_question.dart';

class PlaylistScreen extends StatelessWidget {
  final PlaylistModel playlistModel;

  const PlaylistScreen({super.key, required this.playlistModel});

  @override
  Widget build(BuildContext context) {
    return _PlaylistView(playlistModel: playlistModel);
  }
}

class _PlaylistView extends StatefulWidget {
  final PlaylistModel playlistModel;

  const _PlaylistView({required this.playlistModel});

  @override
  State<_PlaylistView> createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<_PlaylistView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back, color: Colors.white),
        title: const Text(
          "Lectures Playlist",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.primaryColor,
      ),

      body: SafeArea(
        child: BlocConsumer<PlaylistBloc, PlaylistState>(
          listener: (context, state) {
            if (state is PlaylistActionSuccess) {
              AppSnackBar.showSuccess(context, state.message);
            } else if (state is PlaylistFailure) {
              AppSnackBar.showError(context, state.error);
            }
          },
          builder: (context, state) {
            if (state is PlaylistLoaded) {
              return Stack(
                children: [LecturesOnPlayListItem(lectures:
                state.lectures)],
              );
            }
            if (state is PlaylistLoading) {
              return Stack(
                children: [
                  LecturesOnPlayListItem(lectures: state.lectures!),

                  CustomLoadingWidget(),
                ],
              );
            } else if (state is PlaylistActionSuccess) {
              Future.delayed(Duration(seconds: 1), () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.lectures,
                  (route) => false,
                );
              });
              return SizedBox();
            } else {
              return LecturesOnPlayListItem(lectures: []);
            }
          },
        ),
      ),

      floatingActionButton: _buildButtons(),
    );
  }

  Widget _buildButtons() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: AppConstants.w * 0.4,
              height: AppConstants.h * 0.08,
              child: large_admin_button(
                text: "upload lectures",
                onTap: () {
                  context.read<PlaylistBloc>().add(
                    UploadLecturesEvent(widget.playlistModel),
                  );
                },
              ),
            ),

            SizedBox(width: AppConstants.w * 0.01),

            FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: context.read<PlaylistBloc>(),
                      child: AddLectureScreenOnPlayList(isPlayList: true),
                    ),
                  ),
                );

                if (result == true) {
                  context.read<PlaylistBloc>().add(LoadLocalLecturesEvent());
                }
              },
            ),
          ],
        ),

        SizedBox(height: AppConstants.h * 0.05),
      ],
    );
  }
}
