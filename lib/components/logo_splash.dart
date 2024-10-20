import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class LogoSplash extends StatefulWidget {
  const LogoSplash({super.key});

  @override
  State<LogoSplash> createState() => _LogoSplashState();
}

class _LogoSplashState extends State<LogoSplash> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

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
          setState(() {
            _isInitialized = true;
          });
        }
      }).catchError((error) {
        print('Error initializing video: $error');
      });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _controller.value.isInitialized
          ? _controller.value.aspectRatio
          : 1, // Set default value when the video is not initialized
      child: _controller.value.isInitialized
          ? VideoPlayer(_controller) // Render video player when initialized
          : Center(
              child:
                  CircularProgressIndicator()), // Show loading indicator while initializing
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
