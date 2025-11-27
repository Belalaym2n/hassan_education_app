import '../../../../../core/handleErrors/result_pattern.dart';
import '../repositories/get_lect_domain_repo.dart';

class GetPlaylistsUseCase {
  final GetLecturesDomainRepo repo;

  GetPlaylistsUseCase(this.repo);

  Future<Result> get_play_list_call() async {
    final result = await repo.getAllPlaylists();
    if (result.isSuccess) {
      return Result.success(result.data);
    } else {
      return Result.failure(result.error);
    }
  }

  Future<Result> get_lectures_on_play_list_call(String playListID ) async {
    final result = await repo.getLecturesOnPlayList(playListID);
    if (result.isSuccess) {
      return Result.success(result.data);
    } else {
      return Result.failure(result.error);
    }
  }
}
