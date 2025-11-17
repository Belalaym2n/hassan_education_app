import 'dart:async';
import 'package:amr_rezk_education/core/utils/app_colors.dart';
import 'package:amr_rezk_education/core/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class PlayerScreen extends StatefulWidget {
  final String videoId;

  const PlayerScreen({super.key, required this.videoId});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late YoutubePlayerController controller;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  Timer? _timer;
  bool _isDragging = false;
  double? _dragValue;
  @override
  void initState() {
    super.initState();

    controller = YoutubePlayerController.fromVideoId(
      videoId: widget.videoId,

      params: const YoutubePlayerParams(

        showControls: true,
        showFullscreenButton: true,
        mute: false,
        loop: false,
        enableCaption: false,
        pointerEvents: PointerEvents.none,
        enableJavaScript: true,
        origin: 'https://www.youtube-nocookie.com',
      ),
    );


     // نعمل Timer polling كل 500ms لتحديث الزمن الحالي ومدة الفيديو
    _timer = Timer.periodic(const Duration(milliseconds: 500), (_) async {
      if (!mounted) return;
      try {
        final currentSeconds = await controller.currentTime; // double seconds
        final dur = controller.value.metaData.duration ?? Duration.zero;
        setState(() {
          _position = Duration(milliseconds: (currentSeconds * 1000).toInt());
          _duration = dur;
        });
      } catch (e) {
        // ممكن يحصل خطأ مؤقت لو الفيديو مش جاهز — نتجاهله
      }
    });

    // اختياري: حدث جاهزية الميتاداتا لو حابب
    // controller.onEnterFullScreen = () {
    //   // مثال: فعل شئ عند fullscreen
    // };
  }

  String formatTime(Duration d) {
    String two(int n) => n.toString().padLeft(2, '0');
    final h = d.inHours;
    final m = d.inMinutes.remainder(60);
    final s = d.inSeconds.remainder(60);
    return h > 0 ? '${two(h)}:${two(m)}:${two(s)}' : '${two(m)}:${two(s)}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    _duration = const Duration(minutes: 60);

    final maxSeconds = _duration.inSeconds.toDouble();
    var currentSeconds = _position.inSeconds.clamp(0, _duration.inSeconds).toDouble();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // الفيديو
              OrientationBuilder(
                builder: (context, orientation) {
                  final isLand = orientation == Orientation.landscape;

                  print("is $isLand");
                  return Container(
                    height:isLand?
                    MediaQuery.of(context).size.width/ (16 / 6.5)
                      : MediaQuery.of(context).size.width / (16 / 9),

                    child: SizedBox(

                      width: MediaQuery.of(context).size.width,
                      height: isLand
                          ?MediaQuery.of(context).size.width/ (16 / 9)
                          : MediaQuery.of(context).size.width / (16 / 9),
                      child: YoutubePlayer(
                          enableFullScreenOnVerticalDrag: false,
                          controller: controller),
                    ),
                  );
                },
              ),

              const SizedBox(height: 12),

              // Progress bar + times
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
                    Slider(
                      min: 0,
                      max: maxSeconds,
                      value: _isDragging ? _dragValue! : currentSeconds,
                      onChanged: (value) {
                        print("SLIDER DRAGGING -> value = $value");

                        setState(() {
                          _isDragging = true;
                          _dragValue = value;
                          _position = Duration(seconds: value.toInt());
                        });
                      },
                      onChangeEnd: (value) async {
                        print("SLIDER RELEASED -> value = $value");

                        setState(() {
                          _isDragging = false;
                          _dragValue = null;
                          _position = Duration(seconds: value.toInt());
                        });

                        print("SEEKING inside fake test mode...");

                        await controller.seekTo(
                          seconds: value,
                          allowSeekAhead: true,
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(formatTime(_position)),
                        Text(formatTime(_duration)),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),
              buildControlBar()
              // أزرار التحكم

            ],
          ),
        ),
      ),
    );
  }


  Widget buildIconButton({
    required IconData icon,
    required VoidCallback onPressed,
    double size = 30,
    Color color = Colors.black87,
  }) {
    return IconButton(
      icon: Icon(icon, size: size, color: AppColors.primaryColor),
      onPressed: onPressed,
    );
  }

  Widget buildControlBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Back 10 sec
        buildIconButton(
          icon: Icons.replay_10,
          onPressed: () async {
            final current = await controller.currentTime;
            controller.seekTo(seconds: current - 10, allowSeekAhead: true);
          },
        ),

        // Pause
        buildIconButton(
          icon: Icons.pause,
          onPressed: () => controller.pauseVideo(),
        ),

        // Play
        buildIconButton(
          icon: Icons.play_arrow,
          size: 35,
          onPressed: () => controller.playVideo(),
        ),

        // Stop
        buildIconButton(
          icon: Icons.stop,
          onPressed: () => controller.stopVideo(),
        ),

        // Forward 10 sec
        buildIconButton(
          icon: Icons.forward_10,
          onPressed: () async {
            final current = await controller.currentTime;
            controller.seekTo(seconds: current + 10, allowSeekAhead: true);
          },
        ),
      ],
    );
  }

}
