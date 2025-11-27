import '../../../../core/handleErrors/result_pattern.dart';

abstract class GetLecturesDomainRepo {
  Future<Result> getLectures();

  Future<Result> getAllPlaylists();
  Future<Result> getLecturesOnPlayList(String playListID);
}
