import 'package:avarium_avatar_creator/components/image_card.dart';
import 'package:avarium_avatar_creator/components/voice_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:avarium_avatar_creator/models/avatar_creation_model.dart';
import 'package:just_audio/just_audio.dart';

class AvatarCard extends StatefulWidget {
  final String? imageUrl;
  final String? voiceUrl;
  final bool autoPlay;

  const AvatarCard({
    super.key,
    this.imageUrl,
    this.voiceUrl,
    this.autoPlay = true,
  });

  factory AvatarCard.fromModel(AvatarCreationModel model) {
    return AvatarCard(
      imageUrl: model.imageUrl,
      voiceUrl: model.voiceUrl,
      autoPlay: true,
    );
  }

  @override
  State<AvatarCard> createState() => _AvatarCardState();
}

class _AvatarCardState extends State<AvatarCard> {
  final audioPlayer = AudioPlayer();

  Stream<double> get progressStream => audioPlayer.positionStream.map(
        (duration) =>
            duration.inMilliseconds /
            (audioPlayer.duration?.inMilliseconds ?? 1),
      );

  Stream<bool> get isPlayingStream => audioPlayer.playerStateStream.map(
        (state) =>
            state.playing && state.processingState != ProcessingState.completed,
      );

  Future<void> pressPlayButton() async {
    if (audioPlayer.processingState == ProcessingState.completed) {
      await audioPlayer.seek(Duration.zero);
      await audioPlayer.play();
      return;
    }
    if (audioPlayer.playing) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.setUrl(widget.voiceUrl!);
      await audioPlayer.play();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.voiceUrl != null && widget.voiceUrl!.isNotEmpty) {
        audioPlayer.setUrl(widget.voiceUrl!).then((_) {
          if (widget.autoPlay) {
            audioPlayer.play();
            setState(() {});
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: SizedBox(
            width: MediaQuery.of(context).size.height * 0.65,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -100,
                  left: -100,
                  right: -100,
                  bottom: -100,
                  child: Image.asset(
                    'assets/images/ambient_light.png',
                    fit: BoxFit.cover,
                  ),
                ),
                ImageCard(imageUrl: widget.imageUrl),
                if (widget.voiceUrl != null && widget.voiceUrl!.isNotEmpty)
                  Positioned(
                    bottom: 24,
                    left: 16,
                    right: 16,
                    child: VoicePlayer(
                      progressStream: progressStream,
                      isPlayingStream: isPlayingStream,
                      onPlayPressed: pressPlayButton,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}
