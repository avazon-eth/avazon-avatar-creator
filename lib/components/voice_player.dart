import 'package:avarium_avatar_creator/common/colors.dart';
import 'package:avarium_avatar_creator/components/bouncing_widget.dart';
import 'package:avarium_avatar_creator/components/icons.dart';
import 'package:flutter/material.dart';

class VoicePlayer extends StatelessWidget {
  final Stream<double>? progressStream;
  final Stream<bool>? isPlayingStream;
  final VoidCallback? onPlayPressed;

  const VoicePlayer({
    super.key,
    this.progressStream,
    this.isPlayingStream,
    this.onPlayPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: StreamBuilder<bool>(
            stream: isPlayingStream,
            builder: (context, snapshot) {
              final isPlaying = snapshot.data ?? false;
              return BouncingWidget(
                onPressed: onPlayPressed,
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                    color: ColorTable.greyTransparent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                    color: ColorTable.white,
                    size: 40,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 20.0),
        // sound wave
        Expanded(
          child: Container(
            height: 64,
            decoration: BoxDecoration(
              color: ColorTable.greyTransparent,
              borderRadius: BorderRadius.circular(44),
            ),
            child: Stack(
              children: [
                const SvgIcon(
                  iconPath: IconPath.audioWave,
                  color: ColorTable.grey,
                ),
                StreamBuilder<double>(
                  stream: progressStream,
                  builder: (context, snapshot) {
                    final progress = snapshot.data ?? 0.0;
                    return ClipRect(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        widthFactor: progress,
                        child: const SvgIcon(
                          iconPath: IconPath.audioWave,
                          color: ColorTable.white,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
