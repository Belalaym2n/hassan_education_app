import '../../domain/entities/home_video_entity.dart';

abstract class VideoRemoteDataSource {
  Future<VideoEntity> fetchVideoUrl();
}

class VideoRemoteDataSourceImpl implements VideoRemoteDataSource {
  @override
  Future<VideoEntity> fetchVideoUrl() async {
    const String firebaseVideoUrl =
        "https://firebasestorage.googleapis.com/v0/b/codiaadv-826b2.firebasestorage.app/o/videos%2FAQP02gE9Br9EjoIWuX4k03QoDF57Wx1mq8PlpVvgum1F3OlH2RwqpAD_Qc9fWYtiAwa_YgZiDsS3psev7R0JAf74.mp4?alt=media&token=5e1fb362-7f00-468d-91e9-a94e73cb7ac0";
     return VideoEntity(url: firebaseVideoUrl);
  }
}
