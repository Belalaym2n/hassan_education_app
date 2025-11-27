import '../../../../../core/handleErrors/result_pattern.dart';

abstract class GetLecturesDS {
  Future<Result> getLectures();
  Future<Result> getLecturesOnPlaylist(String playListID);
  Future<Result> getPlayLists();
}
