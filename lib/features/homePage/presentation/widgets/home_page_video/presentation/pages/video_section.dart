//  import 'package:amr_rezk_education/core/utils/app_constants.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../data/data_sources/home_video_ds.dart';
// import '../../data/repositories/video_repo_iml.dart';
// import '../../domain/repositories/home_video_repo.dart';
// import '../../domain/use_cases/home_video_use_case.dart';
// import '../bloc/bloc.dart';
// import '../bloc/states.dart';
// import '../bloc/video_event.dart';
// import '../widgets/loading_widget_player.dart';
//
// class VideoPage extends StatefulWidget {
//   const VideoPage({
//     super.key,
//     this.isDesktop = true,
//     required this.w,
//     required this.h,
//   });
//
//   final double w;
//   final double h;
//   final bool isDesktop;
//
//   @override
//   State<VideoPage> createState() => _VideoPageState();
// }
//
// class _VideoPageState extends State<VideoPage>
//     with AutomaticKeepAliveClientMixin {
//   @override
//   bool get wantKeepAlive => true; // ✅ يحافظ على الفيديو لما تنقل بين الشاشات
//
//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//
//     final remoteDS = VideoRemoteDataSourceImpl();
//     final VideoRepository repo = VideoRepositoryImpl(remoteDS);
//     final getVideoUrl = GetVideoUrl(repo);
//
//     return BlocProvider.value(
//       value: VideoBloc.getInstance(getVideoUrl: getVideoUrl)..add(LoadVideoEvent()),
//
//        child: BlocBuilder<VideoBloc, VideoState>(
//         builder: (context, state) {
//           if (state is VideoLoading || state is VideoLoaded) {
//             return SizedBox(
//               width: widget.w,
//               height:widget.h * 0.4,
//               child: const Center(child: LoadingVideoPlaceholder()),
//             );
//           } else if (state is VideoReady) {
//             final controller = state.controller;
//
//             // ✅ نتأكد إنه شغال بعد الرجوع
//             if (!controller.value.isPlaying) {
//               controller.play();
//             }
//
//
//
//             return  LayoutBuilder(
//               builder: (context, constraints) {
//                 return SizedBox(
//                   height: AppConstants.h*0.24,
//                   width: constraints.maxWidth,
//                   child: AspectRatio(
//
//                     aspectRatio: controller.value.aspectRatio,
//                     // child: VideoPlayer(controller),
//                   ),
//                 );
//               },
//             );
//           } else if (state is VideoError) {
//             return Center(child: Text("Error: ${state.message}"));
//           }
//           return const SizedBox();
//         },
//       ),
//     );
//   }
// }
