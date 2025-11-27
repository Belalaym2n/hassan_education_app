// features/playlist/data/repositories/playlist_data_repo.dart
import 'package:amr_rezk_education/core/cahsing/app_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../../../../core/cahsing/get_storage_helper.dart';
import '../../../../../core/handleErrors/result_pattern.dart';
import '../../../../lectures/data/models/play_list_model.dart';
import '../../domain/repositories/add_play_list_domain_repo.dart';
import '../data_sources/local/play_list_local.dart';
import '../data_sources/remote/playLIST/add_playlist_ds.dart';
import '../models/lecture_model.dart';

class PlaylistDataRepo implements PlaylistDomainRepo {
  final PlaylistDS playlistDS;

  final PlayListLocalDS localDS;

  PlaylistDataRepo({required this.playlistDS, required this.localDS});

  @override
  Future<Result> addLocalLecture(LectureModel lecture) {
    return localDS.addLocalLecture(lecture);
  }

  @override
  Future<Result> getLocalLectures() {
    return localDS.getLocalLectures();
  }

  @override
  Future<Result> removeLocalLecture(String id) {
    return localDS.removeLocalLecture(id);
  }

  @override
  Future<Result> clearLocalLectures() {
    return localDS.clearLocalLectures();
  }

  // ===== Upload =====
  @override
  Future<Result> uploadLectures(
    List<LectureModel> lectures,
    String playlistId, {
    required String stage,
    required PlaylistModel model,
  }) async {
    try {
      final res = await playlistDS.uploadLecturesToFirestore(
        lectures,
        playlistId,
        stage: stage,
        model: model,
      );
      if (res.isSuccess) {
        await clearLocalLectures();
        return Result.success("uploaded_and_cleared_local");
      } else {
        return Result.failure(res.error);
      }
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
