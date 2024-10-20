import 'dart:async';

import 'package:avarium_avatar_creator/components/layout.dart';
import 'package:avarium_avatar_creator/components/primary_button.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:avarium_avatar_creator/common/utils.dart';
import 'package:avarium_avatar_creator/components/avatar_card.dart';
import 'package:avarium_avatar_creator/models/common/fair_model.dart';
import 'package:avarium_avatar_creator/providers/avatar_detail_provider.dart';
import 'package:avarium_avatar_creator/providers/avatar_video_create_provider.dart';
import 'package:avarium_avatar_creator/components/secondary_button.dart';
import 'package:avarium_avatar_creator/common/colors.dart';
import 'package:avarium_avatar_creator/components/dark_shined_panel.dart';
import 'package:avarium_avatar_creator/components/text_field.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_indicator/loading_indicator.dart';

/// from avatar_use_video_screen -> generating video started
/// HTTP polling applied
class AvatarCreateVideoWithImageScreen extends ConsumerStatefulWidget {
  static const routeName = 'avatar-create-video-with-image';

  final String avatarId;
  final String videoCreationId;

  const AvatarCreateVideoWithImageScreen({
    super.key,
    required this.avatarId,
    required this.videoCreationId,
  });

  @override
  ConsumerState<AvatarCreateVideoWithImageScreen> createState() =>
      _AvatarUseVideoWithImageScreenState();
}

class _AvatarUseVideoWithImageScreenState
    extends ConsumerState<AvatarCreateVideoWithImageScreen> {
  late Timer _timer;
  AvatarVideoCreateStateNotifier get notifier => ref.read(
      avatarVideoCreateProvider(Pair(widget.avatarId, widget.videoCreationId))
          .notifier);

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      notifier.fetch();
    });
  }

  @override
  Widget build(BuildContext context) {
    final avatar = ref.watch(avatarDetailProvider(widget.avatarId));
    final videoCreation = ref.watch(avatarVideoCreateProvider(
      Pair(widget.avatarId, widget.videoCreationId),
    ));
    bool imageGenerated = videoCreation?.thumbnailUrl != null;
    var deviceSize = MediaQuery.of(context).size;
    return AvatarLayout(
      avatar: Stack(
        children: [
          Center(
            child: AvatarCard(
              imageUrl: videoCreation?.thumbnailUrl ?? avatar?.profileImageUrl,
            ),
          ),
          if (!imageGenerated)
            const Center(
              child: SizedBox(
                width: 100,
                height: 100,
                child: LoadingIndicator(
                  indicatorType: Indicator.ballPulseSync,
                  colors: [
                    ColorTable.lightGrey,
                  ],
                ),
              ),
            ),
        ],
      ),
      panel: Container(
        padding: const EdgeInsets.all(24.0),
        height: deviceSize.height * 0.85,
        child: Column(
          children: [
            Expanded(
              child: DarkShinedPanel(
                child: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Making a video',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: ColorTable.white.withOpacity(0.4),
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        const Text(
                          'Generate a video',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: ColorTable.white,
                          ),
                        ),
                        const SizedBox(height: 24.0),
                        const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Title',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: ColorTable.white,
                                ),
                              ),
                              SizedBox(height: 16.0),
                              CustomTextField(
                                maxLines: 1,
                                hintText: 'Video Title',
                              ),
                              SizedBox(height: 24.0),
                              Text(
                                'Description',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: ColorTable.white,
                                ),
                              ),
                              SizedBox(height: 16.0),
                              CustomTextField(
                                maxLines: 16,
                                hintText: 'Enter a prompt',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            Row(
              children: [
                const Spacer(
                  flex: 3,
                ),
                Expanded(
                  flex: 2,
                  child: SecondaryButton(
                    text: 'Back',
                    onPressed: () async {
                      await AwesomeDialog(
                        context: context,
                        dialogType: DialogType.noHeader,
                        title: 'Cancel Video Creation',
                        desc: 'Are you sure you want to cancel video creation?',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {
                          // cancel
                          context.pop();
                        },
                        width: 500, // Set width to a maximum of 500
                        btnCancelColor:
                            ColorTable.grey, // Change button color for cancel
                        btnOkColor:
                            ColorTable.primary, // Change button color for OK
                      ).show();
                    },
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  flex: 3,
                  child: PrimaryButton(
                    text: 'Generate',
                    blurRadius: imageGenerated ? 16 : 0,
                    onPressed: () {
                      if (!imageGenerated) {
                        Utils.showToast('Waiting for image generation');
                        return;
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
