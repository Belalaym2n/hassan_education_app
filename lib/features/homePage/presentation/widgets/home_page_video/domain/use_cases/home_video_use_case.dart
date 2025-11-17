
import '../entities/home_video_entity.dart';
import '../repositories/home_video_repo.dart';

class GetVideoUrl {
  final VideoRepository repository;

  GetVideoUrl(this.repository);

  Future<VideoEntity> call() async {
    return await repository.getVideoUrl();
  }
}
