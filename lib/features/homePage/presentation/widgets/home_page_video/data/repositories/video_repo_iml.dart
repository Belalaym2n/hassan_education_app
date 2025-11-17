// features/company_profile_video/data/repositories/video_repository_impl.dart

import '../../domain/entities/home_video_entity.dart';
import '../../domain/repositories/home_video_repo.dart';
import '../data_sources/home_video_ds.dart';

class VideoRepositoryImpl implements VideoRepository {
  final VideoRemoteDataSource remoteDataSource;

  VideoRepositoryImpl(this.remoteDataSource);

  @override
  Future<VideoEntity> getVideoUrl() async {
    return await remoteDataSource.fetchVideoUrl();
  }
}
