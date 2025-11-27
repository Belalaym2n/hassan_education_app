import '../../../../core/handleErrors/result_pattern.dart';
import '../../domain/repositories/get_lect_domain_repo.dart';
import '../data_sources/remote/get_lect_ds.dart';

class GetLecturesDataRepo implements GetLecturesDomainRepo {
  final GetLecturesDS getLecturesDS;

  GetLecturesDataRepo(this.getLecturesDS);

  @override
  Future<Result> getLectures() {
    return getLecturesDS.getLectures();
  }

  @override
  Future<Result> getAllPlaylists() {
    return getLecturesDS.getPlayLists();
  }

  @override
  Future<Result> getLecturesOnPlayList(String playListID) {
    // TODO: implement getLecturesOnPlayList
    return getLecturesDS.getLecturesOnPlaylist(playListID);
  }
}
