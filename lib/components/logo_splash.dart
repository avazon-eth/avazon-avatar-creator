import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// play assets/videos/plash.mp4
class LogoSplash extends StatefulWidget {
  const LogoSplash({super.key});

  @override
  State<LogoSplash> createState() => _LogoSplashState();
}

class _LogoSplashState extends State<LogoSplash> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
      'assets/videos/splash.mp4',
      videoPlayerOptions: VideoPlayerOptions(
        mixWithOthers: true,
        allowBackgroundPlayback: true,
      ),
    )..initialize().then((_) async {
        _controller.setLooping(true);
        _controller.setVolume(0);
        await _controller.play();
        if (mounted) {
          setState(() {});
        }
      }).catchError((error) {
        print('Error initializing video: $error');
      });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: VideoPlayer(_controller),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
