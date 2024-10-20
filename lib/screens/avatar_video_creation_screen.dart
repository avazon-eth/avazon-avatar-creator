import 'package:avarium_avatar_creator/components/dark_shined_panel.dart';
import 'package:avarium_avatar_creator/components/layout.dart';
import 'package:avarium_avatar_creator/components/primary_button.dart';
import 'package:avarium_avatar_creator/components/secondary_button.dart';
import 'package:avarium_avatar_creator/components/text_field.dart';
import 'package:avarium_avatar_creator/models/avatar_video_creation_model.dart';
import 'package:avarium_avatar_creator/providers/avatar_detail_provider.dart';
import 'package:avarium_avatar_creator/providers/web_data_session_provider.dart';
import 'package:avarium_avatar_creator/screens/avatar_video_with_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:avarium_avatar_creator/components/avatar_card.dart';
import 'package:avarium_avatar_creator/repository/avatar_repository.dart';
import 'package:avarium_avatar_creator/common/utils.dart';
import 'package:avarium_avatar_creator/common/colors.dart';
import 'package:go_router/go_router.dart';

class AvatarCreateVideoScreen extends ConsumerStatefulWidget {
  static const routeName = 'create-avatar-video';

  final String avatarId;
  final String tokenKey;

  const AvatarCreateVideoScreen({
    super.key,
    required this.avatarId,
    required this.tokenKey,
  });

  @override
  ConsumerState<AvatarCreateVideoScreen> createState() =>
      _AvatarUseVideoScreenState();
}

class _AvatarUseVideoScreenState
    extends ConsumerState<AvatarCreateVideoScreen> {
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.tokenKey.isEmpty) {
        Utils.showErrorToast(message: 'Error occurred. Invalid access token.');
      } else {
        Utils.d('token_key: ${widget.tokenKey}');
        ref.read(webTokenProvider.notifier).initWith(widget.tokenKey);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final avatar = ref.watch(avatarDetailProvider(widget.avatarId));
    var deviceSize = MediaQuery.of(context).size;
    return AvatarLayout(
      avatar: AvatarCard(
        imageUrl: avatar?.profileImageUrl,
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
                          'Make a Reference Image',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: ColorTable.white,
                          ),
                        ),
                        const SizedBox(height: 24.0),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Description',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: ColorTable.white,
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              CustomTextField(
                                controller: descriptionController,
                                minLines: 6,
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
                    text: 'Cancel',
                    onPressed: () {
                      context.pop();
                    },
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  flex: 3,
                  child: PrimaryButton(
                    text: 'Next',
                    blurRadius: 0,
                    onPressed: () async {
                      try {
                        String description = descriptionController.value.text;
                        if (description.isEmpty) {
                          Utils.showToast('Please enter a prompt');
                          return;
                        }
                        final videoCreation = await ref
                            .read(avatarRepositoryProvider)
                            .createVideoImage(
                                AvatarVideoImageCreationRequestModel(
                                  prompt: description,
                                ),
                                avatarId: widget.avatarId);
                        if (context.mounted) {
                          context.pushNamed(
                            AvatarCreateVideoWithImageScreen.routeName,
                            pathParameters: {
                              'avatar_id': widget.avatarId,
                              'creation_id': videoCreation.id,
                            },
                          );
                        }
                      } catch (e) {
                        Utils.d(e.toString());
                        Utils.showToast('Error creating video');
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
}
