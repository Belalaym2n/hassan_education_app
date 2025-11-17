// features/company_profile_video/domain/repositories/video_repository.dart
import '../entities/home_video_entity.dart';
 
abstract class VideoRepository {
  Future<VideoEntity> getVideoUrl();
}
