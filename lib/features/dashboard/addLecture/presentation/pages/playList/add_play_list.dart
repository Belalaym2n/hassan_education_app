import 'package:amr_rezk_education/features/dashboard/addLecture/presentation/bloc/playListBloc/play_list_states.dart';
import 'package:amr_rezk_education/features/dashboard/addLecture/presentation/pages/playList/play_list_lectures_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/intialization/init_di.dart';
import '../../../../../../core/sharedWidgets/app_snack_bar.dart';

import '../../../domain/use_cases/add_play_list_use_cases.dart';
import '../../bloc/playListBloc/play_list_bloc.dart';

import '../../widgets/play_list_lectures/add_play_list_item.dart';

class AddPlaylistScreen extends StatefulWidget {
  const AddPlaylistScreen({super.key});

  @override
  State<AddPlaylistScreen> createState() => _AddPlaylistScreenState();
}

class _AddPlaylistScreenState extends State<AddPlaylistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("إنشاء Playlist شهرية")),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: BlocProvider(
          create: (_) => PlaylistBloc(
            addLectureUseCase: getIt<AddLectureUseCase>(),
            getLocalLecturesUseCase: getIt<GetLocalLecturesUseCase>(),
            removeLocalLectureUseCase: getIt<RemoveLocalLectureUseCase>(),
            uploadLecturesUseCase: getIt<UploadLecturesUseCase>(),
          ), // ← أول Event يتحط هنا
          child: BlocBuilder<PlaylistBloc, PlaylistState>(
            builder: (context, state) {
              return AddPlayListItem();
            },
          ),
        ),
      ),
    );
  }
}
