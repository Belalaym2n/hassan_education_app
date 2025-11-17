import 'package:amr_rezk_education/features/dashboard/addLecture/data/data_sources/local/play_list_local.dart';

import '../../../../../../core/handleErrors/exaption_handler.dart';
import '../../../../../../core/handleErrors/result_pattern.dart';
import '../../models/lecture_model.dart';
import 'package:amr_rezk_education/core/cahsing/app_keys.dart';
import 'package:amr_rezk_education/core/cahsing/get_storage_helper.dart';

class PlayListLocalDSImp implements PlayListLocalDS {
  @override
  Future<Result> addLocalLecture(LectureModel lecture) async {
    try {
      final existing = GetStorageHelper.read(AppKeys.localLectures);

      List<LectureModel> list = [];
      if (existing != null && existing.isNotEmpty) {
        list = LectureModel.decodeList(existing);
      }

      list.add(lecture);

      await GetStorageHelper.write(
        AppKeys.localLectures,
        LectureModel.encodeList(list),
      );

      return Result.success("saved_local");
    } catch (e) {
      final exception = ExceptionHandler.handle(e);
      final failure = ExceptionHandler.exceptionToFailure(exception);
      return Result.failure(failure.message.toString());
    }
  }

  @override
  Future<Result> getLocalLectures() async {
    try {
      final existing = GetStorageHelper.read(AppKeys.localLectures);

      if (existing == null || existing.isEmpty) {
        return Result.success(<LectureModel>[]);
      }

      final list = LectureModel.decodeList(existing);
      return Result.success(list);
    } catch (e) {
      final exception = ExceptionHandler.handle(e);
      final failure = ExceptionHandler.exceptionToFailure(exception);
      return Result.failure(failure.message.toString());
    }
  }

  @override
  Future<Result> removeLocalLecture(String id) async {
    try {
      final existing = GetStorageHelper.read(AppKeys.localLectures);

      if (existing == null || existing.isEmpty) {
        return Result.failure("no_local_data");
      }

      var list = LectureModel.decodeList(existing);
      list.removeWhere((e) => e.id == id);

      await GetStorageHelper.write(
        AppKeys.localLectures,
        LectureModel.encodeList(list),
      );

      return Result.success("removed");
    } catch (e) {
      final exception = ExceptionHandler.handle(e);
      final failure = ExceptionHandler.exceptionToFailure(exception);
      return Result.failure(failure.message.toString());
    }
  }

  @override
  Future<Result> clearLocalLectures() async {
    try {
      await GetStorageHelper.remove(AppKeys.localLectures);
      return Result.success("cleared");
    } catch (e) {
      final exception = ExceptionHandler.handle(e);
      final failure = ExceptionHandler.exceptionToFailure(exception);
      return Result.failure(failure.message.toString());
    }
  }
}
