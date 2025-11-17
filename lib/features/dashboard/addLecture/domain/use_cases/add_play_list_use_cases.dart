// features/playlist/domain/use_cases/playlist_usecases.dart
import '../../../../../core/handleErrors/result_pattern.dart';
 import '../repositories/add_play_list_domain_repo.dart';
 import '../../data/models/lecture_model.dart';

class AddLectureUseCase {
  final PlaylistDomainRepo repo;
  AddLectureUseCase({required this.repo});

  Future<Result> call(LectureModel lecture) async {
    return await repo.addLocalLecture(lecture);
  }
}

class GetLocalLecturesUseCase {
  final PlaylistDomainRepo repo;
  GetLocalLecturesUseCase({required this.repo});

  Future<Result> call() async {
    return await repo.getLocalLectures();
  }
}

class RemoveLocalLectureUseCase {
  final PlaylistDomainRepo repo;
  RemoveLocalLectureUseCase({required this.repo});

  Future<Result> call(String id) async {
    return await repo.removeLocalLecture(id);
  }
}

class UploadLecturesUseCase {
  final PlaylistDomainRepo repo;
  UploadLecturesUseCase({required this.repo});

  Future<Result> call(List<LectureModel> lectures, String playlistId) async {
    return await repo.uploadLectures(lectures, playlistId);
  }
}
