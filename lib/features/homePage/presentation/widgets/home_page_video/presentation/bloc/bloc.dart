// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:video_player/video_player.dart';
// import '../../domain/use_cases/home_video_use_case.dart';
// import 'video_event.dart';
// import 'states.dart';
//
// class VideoBloc extends Bloc<VideoEvent, VideoState> {
//   final GetVideoUrl getVideoUrl;
//   bool isLoadedBefore = false;
//   static VideoBloc? _instance;
//   static VideoBloc getInstance({required GetVideoUrl getVideoUrl}) {
//     _instance ??= VideoBloc._internal(getVideoUrl);
//     return _instance!;
//   }
//   VideoBloc._internal(this.getVideoUrl) : super(VideoInitial()) {
//     on<LoadVideoEvent>((event, emit) async {
//       if (isLoadedBefore) return; //
//       emit(VideoLoading());
//        try {
//         final videoEntity = await getVideoUrl();
//         emit(VideoLoaded(videoEntity));
//
//         final controller =
//         VideoPlayerController.network(videoEntity.url,);
//         await controller.initialize();
//         controller.setVolume(0);
//         controller.setLooping(true);
//         controller.play();
//
//         isLoadedBefore = true; // ✅ أول مرة بس
//
//         emit(VideoReady(controller));
//       } catch (e) {
//          print("error ${e.toString()}");
//         emit(VideoError(e.toString()));
//       }
//     });
//   }
//
//
// }
