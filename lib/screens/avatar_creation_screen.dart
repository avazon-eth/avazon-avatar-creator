import 'package:avarium_avatar_creator/common/utils.dart';
import 'package:avarium_avatar_creator/components/avatar_card.dart';
import 'package:avarium_avatar_creator/components/chatting_input.dart';
import 'package:avarium_avatar_creator/components/chatting_panel.dart';
import 'package:avarium_avatar_creator/components/creation_indicator.dart';
import 'package:avarium_avatar_creator/components/image_button.dart';
import 'package:avarium_avatar_creator/components/image_card.dart';
import 'package:avarium_avatar_creator/components/layout.dart';
import 'package:avarium_avatar_creator/components/logo_splash.dart';
import 'package:avarium_avatar_creator/components/primary_button.dart';
import 'package:avarium_avatar_creator/components/secondary_button.dart';
import 'package:avarium_avatar_creator/components/shined.dart';
import 'package:avarium_avatar_creator/common/colors.dart';
import 'package:avarium_avatar_creator/components/text_field.dart';
import 'package:avarium_avatar_creator/components/text_toggle.dart';
import 'package:avarium_avatar_creator/components/voice_player.dart';
import 'package:avarium_avatar_creator/models/avatar_creation_chat_model.dart';
import 'package:avarium_avatar_creator/models/avatar_creation_model.dart';
import 'package:avarium_avatar_creator/providers/avatar_creation_provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

enum Gender {
  male,
  female,
  other;

  String get displayName {
    switch (this) {
      case Gender.male:
        return 'Male';
      case Gender.female:
        return 'Female';
      case Gender.other:
        return 'Other';
    }
  }
}

class AvatarCreationScreen extends ConsumerStatefulWidget {
  static const routeName = 'avatar-creation';

  // used on <iframe/> wrapper. Will be used only once on the first page load.
  final String webSessionId;

  const AvatarCreationScreen({super.key, required this.webSessionId});

  @override
  ConsumerState<AvatarCreationScreen> createState() =>
      _AvatarCreationScreenState();
}

class _AvatarCreationScreenState extends ConsumerState<AvatarCreationScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _progressTabController;
  int currentProgressTab = 0;

  AvatarStyle avatarStyle = AvatarStyle.realistic;
  final nameController = TextEditingController();
  final speciesController = TextEditingController(text: 'Human');
  Gender gender = Gender.male;
  final countryController = TextEditingController();
  final descriptionController = TextEditingController();
  // chattings
  final appearanceChattingController = TextEditingController();
  final characterChattingController = TextEditingController();
  final voiceChattingController = TextEditingController();

  String get profileName => nameController.value.text;
  String get profileSpecies => speciesController.value.text;
  String get profileCountry => countryController.value.text;
  String get profileDescription => descriptionController.value.text;

  bool get filledProfile =>
      profileName.isNotEmpty &&
      profileSpecies.isNotEmpty &&
      profileCountry.isNotEmpty;

  Widget avatarCard(AvatarCreationModel? model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 350),
          child: SizedBox(
            width: MediaQuery.of(context).size.height * 0.65,
            child: Stack(
              children: [
                // if (model.imageUrl != null && model.imageUrl!.isNotEmpty)
                //   GidImageCard(imageUrl: model.imageUrl!)
                // else
                //   const Center(
                //     child: SizedBox(
                //       width: 40,
                //       height: 40,
                //       child: CircularProgressIndicator(
                //         strokeWidth: 4.0,
                //       ),
                //     ),
                //   ),
                ImageCard(imageUrl: model?.imageUrl),
                if (model?.voiceUrl != null && model!.voiceUrl!.isNotEmpty)
                  Positioned(
                    bottom: 24,
                    left: 16,
                    right: 16,
                    child: VoicePlayer(
                      progressStream: ref
                          .read(avatarCreationProvider.notifier)
                          .progressStream,
                      isPlayingStream: ref
                          .read(avatarCreationProvider.notifier)
                          .isPlayingStream,
                      onPlayPressed: ref
                          .read(avatarCreationProvider.notifier)
                          .pressPlayButton,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget panelProfileLabel(String text, [String? subtext]) {
    Widget ret = Text(
      text,
      style: const TextStyle(
        fontSize: 20.0,
        height: 1.25,
        color: ColorTable.white,
      ),
    );
    if (subtext != null) {
      ret = Row(
        children: [
          ret,
          Text(
            subtext,
            style: TextStyle(
              fontSize: 16.0,
              height: 1.25,
              color: ColorTable.white.withOpacity(0.5),
            ),
          ),
        ],
      );
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 12.0, 0, 7.0),
      child: ret,
    );
  }

  Widget ph24v10({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
      child: child,
    );
  }

  Widget chatPanel(
      {required List<AvatarCreationChatModel> chats,
      required Stream<String>? messageStream}) {
    return ChattingScroll(
      otherIcon: Image.asset(
        'assets/images/gid_assistant.png',
      ),
      items: chats
          .map((e) => ChattingModel(
                isMine: e.role == 'user',
                message: e.content,
              ))
          .toList(),
      messageStream: messageStream,
    );
  }

  Widget get progressText => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Progress',
            style: TextStyle(
              fontSize: 16.0,
              height: 1.25,
              color: ColorTable.white.withOpacity(0.4),
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            'Step ${currentProgressTab + 1}',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w600,
              height: 1.25,
              color: ColorTable.white.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 4.0),
        ],
      );

  Widget panelTabBar(AvatarCreationModel? avatarCreation) => TabBar(
        controller: _progressTabController,
        indicatorWeight: 3.0,
        indicatorColor: ColorTable.lightGrey,
        dividerHeight: 0,
        padding: EdgeInsets.zero,
        labelPadding: EdgeInsets.zero,
        onTap: onProgressTap,
        tabs: [
          Tab(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 18,
                    height: 18,
                    child: AvatarCreationIndicator(
                      progress: avatarCreation != null ? 3 : 1,
                    ),
                  ),
                  const SizedBox(width: 6.0),
                  const Flexible(
                    child: Text(
                      'Profile',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Tab(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 18,
                    height: 18,
                    child: AvatarCreationIndicator(
                      progress: avatarCreation?.imageStatus.progressNumber ?? 0,
                    ),
                  ),
                  const SizedBox(width: 6.0),
                  const Flexible(
                    child: Text(
                      'Appearance',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Tab(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 18,
                    height: 18,
                    child: AvatarCreationIndicator(
                      progress:
                          avatarCreation?.characterStatus.progressNumber ?? 0,
                    ),
                  ),
                  const SizedBox(width: 6.0),
                  const Flexible(
                    child: Text(
                      'Character',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Tab(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 18,
                    height: 18,
                    child: AvatarCreationIndicator(
                      progress: avatarCreation?.voiceStatus.progressNumber ?? 0,
                      waitingSeconds: 20,
                    ),
                  ),
                  const SizedBox(width: 6.0),
                  const Flexible(
                    child: Text(
                      'Voice',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );

  Future<void> askToReset() async {
    await AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      title: 'Reset Avatar Creation',
      desc: 'Are you sure you want to reset avatar creation?',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        // reset
        ref.read(avatarCreationProvider.notifier).reset();
        setState(() => currentProgressTab = 0);
        _progressTabController.animateTo(currentProgressTab);
      },
      width: 500, // Set width to a maximum of 500
      btnCancelColor: ColorTable.grey, // Change button color for cancel
      btnOkColor: ColorTable.purple2, // Change button color for OK
    ).show();
  }

  Future<void> askToCancel() async {
    await AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      title: 'Cancel Avatar Creation',
      desc: 'Are you sure you want to cancel avatar creation?',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        // cancel
        ref.read(avatarCreationProvider.notifier).reset();
        context.pop();
      },
      width: 500, // Set width to a maximum of 500
      btnCancelColor: ColorTable.grey, // Change button color for cancel
      btnOkColor: ColorTable.purple2, // Change button color for OK
    ).show();
  }

  /// 0: Profile, 1: Appearance, 2: Character, 3: Voice
  void onProgressTap(int index) async {
    if (index == 0 && currentProgressTab != 0) {
      _progressTabController.index = currentProgressTab;
      askToReset();
      return;
    }
    if (index > 0 && currentProgressTab == 0) {
      if (!filledProfile) {
        Utils.showToast('Please fill the profile first');
        _progressTabController.index = currentProgressTab;
        return;
      } else {
        await goNext();
        _progressTabController.index = index;
      }
    }
    setState(() => currentProgressTab = index);
  }

  void sendMessage({required String objectType, required String message}) {
    ref
        .read(avatarCreationProvider.notifier)
        .sendMessage(objectType: objectType, message: message);
  }

  Future<void> goNext() async {
    if (currentProgressTab == 0) {
      // check if filled the Profile
      if (profileName.isEmpty) {
        Utils.showToast('Please enter avatar name');
        return;
      }
      if (profileSpecies.isEmpty) {
        Utils.showToast('Please enter avatar species');
        return;
      }
      if (profileCountry.isEmpty) {
        Utils.showToast('Please enter avatar country');
        return;
      }
      await ref.read(avatarCreationProvider.notifier).startSession(
            AvatarCreationRequestModel(
              name: profileName,
              species: profileSpecies,
              country: profileCountry,
              gender: gender.name,
              age: 20,
              language: 'English',
              imageStyle: avatarStyle,
            ),
          );
    }

    var creationModel = ref.read(avatarCreationProvider);
    bool isReadyToCreate = creationModel?.canCreateNow ?? false;

    if (isReadyToCreate) {
      createAvatar();
    } else {
      if (currentProgressTab < 3) {
        setState(() => currentProgressTab += 1);
        _progressTabController.animateTo(currentProgressTab);
      } else {
        // validation message
        if (creationModel == null) {
          Utils.showToast('Please fill the profile first');
        } else if (!creationModel.imageStatus.isCompleted) {
          Utils.showToast('Image is not ready');
          setState(() => currentProgressTab = 1);
          _progressTabController.animateTo(currentProgressTab);
        } else if (!creationModel.characterStatus.isCompleted) {
          Utils.showToast('Character is not ready');
          setState(() => currentProgressTab = 2);
          _progressTabController.animateTo(currentProgressTab);
        } else if (!creationModel.voiceStatus.isCompleted) {
          Utils.showToast('Voice is not ready');
          setState(() => currentProgressTab = 3);
          _progressTabController.animateTo(currentProgressTab);
        }
      }
    }
  }

  Future<void> createAvatar() async {
    // TODO : go to license agreement screen
  }

  @override
  void initState() {
    super.initState();
    _progressTabController = TabController(length: 4, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(avatarCreationProvider.notifier).reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    final AvatarCreationModel? avatarCreation =
        ref.watch(avatarCreationProvider);
    String? imageUrl = avatarCreation?.imageUrl;
    final chats1 = ref.watch(avatarCreationChatProvider('image'));
    final chat1Stream =
        ref.read(avatarCreationChatProvider('image').notifier).messageStream;
    final chats2 = ref.watch(avatarCreationChatProvider('character'));
    final chat2Stream = ref
        .read(avatarCreationChatProvider('character').notifier)
        .messageStream;
    final chats3 = ref.watch(avatarCreationChatProvider('voice'));
    final chat3Stream =
        ref.read(avatarCreationChatProvider('voice').notifier).messageStream;

    final panel = Column(
      children: [
        const SizedBox(height: 26.0),
        Expanded(
          child: Stack(
            children: [
              const Positioned.fill(
                child: Opacity(
                  opacity: 0.2,
                  child: Shined(
                    backgroundColor: ColorTable.greyTransparent,
                    borderRadius: 24.0,
                    child: SizedBox(
                      width: double.infinity,
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 17.0, vertical: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, bottom: 5.0),
                      child: progressText,
                    ),
                    panelTabBar(avatarCreation),
                    Expanded(
                      child: TabBarView(
                        controller: _progressTabController,
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 12.0),
                                panelProfileLabel('Style'),
                                ph24v10(
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 100,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: ImageButton(
                                            onPressed: () {
                                              setState(() => avatarStyle =
                                                  AvatarStyle.realistic);
                                            },
                                            isSelected: avatarStyle ==
                                                AvatarStyle.realistic,
                                            imageProvider: const AssetImage(
                                              'assets/images/avatar_style_realistic.jpg',
                                            ),
                                            label: 'Realistic',
                                          ),
                                        ),
                                        const SizedBox(width: 10.0),
                                        Expanded(
                                          child: ImageButton(
                                            onPressed: () {
                                              setState(() => avatarStyle =
                                                  AvatarStyle.cartoon);
                                            },
                                            isSelected: avatarStyle ==
                                                AvatarStyle.cartoon,
                                            imageProvider: const AssetImage(
                                              'assets/images/avatar_style_cartoon.jpg',
                                            ),
                                            label: 'Cartoon',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                panelProfileLabel('Name'),
                                ph24v10(
                                    child: CustomTextField(
                                        controller: nameController)),
                                panelProfileLabel('Species'),
                                ph24v10(
                                    child: CustomTextField(
                                        controller: speciesController)),
                                panelProfileLabel('Gender'),
                                ph24v10(
                                  child: TextToggle(
                                    borderRadius: 8.0,
                                    values: const ['Male', 'Female', 'Other'],
                                    current: gender.displayName,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = Gender.values.firstWhere((e) =>
                                            e.name.toLowerCase() ==
                                            value.toLowerCase());
                                      });
                                    },
                                  ),
                                ),
                                panelProfileLabel('Country'),
                                ph24v10(
                                    child: CustomTextField(
                                        controller: countryController)),
                                panelProfileLabel('Description', '(Optional)'),
                                ph24v10(
                                  child: CustomTextField(
                                    controller: descriptionController,
                                    minLines: 3,
                                    maxLines: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Expanded(
                                child: chatPanel(
                                  chats: chats1,
                                  messageStream: chat1Stream,
                                ),
                              ),
                              ChattingInput(
                                onSend: (text) {
                                  sendMessage(
                                    objectType: 'image',
                                    message: text,
                                  );
                                  appearanceChattingController.clear();
                                },
                                controller: appearanceChattingController,
                                isWaiting: chat1Stream != null,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Expanded(
                                child: chatPanel(
                                  chats: chats2,
                                  messageStream: chat2Stream,
                                ),
                              ),
                              ChattingInput(
                                onSend: (text) {
                                  sendMessage(
                                    objectType: 'character',
                                    message: text,
                                  );
                                  characterChattingController.clear();
                                },
                                controller: characterChattingController,
                                isWaiting: chat2Stream != null,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Expanded(
                                child: chatPanel(
                                  chats: chats3,
                                  messageStream: chat3Stream,
                                ),
                              ),
                              ChattingInput(
                                onSend: (text) {
                                  sendMessage(
                                    objectType: 'voice',
                                    message: text,
                                  );
                                  voiceChattingController.clear();
                                },
                                controller: voiceChattingController,
                                isWaiting: chat3Stream != null,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20.0),
        Row(
          children: [
            const Spacer(),
            Expanded(
              child: SecondaryButton(
                text: 'Cancel',
                onPressed: askToCancel,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: PrimaryButton(
                onPressed: avatarCreation?.canCreateNow == true
                    ? createAvatar
                    : goNext,
                blurRadius: avatarCreation?.canCreateNow == true ? 16 : 0,
                text: avatarCreation?.canCreateNow == true ? 'Create' : 'Next',
              ),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
      ],
    );

    return Scaffold(
      backgroundColor: ColorTable.systemBlack3,
      body: AvatarLayout(
        avatar: avatarCreation?.imageUrl == null
            ? const LogoSplash()
            : AvatarCard.fromModel(avatarCreation!),
        panel: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: panel,
        ),
      ),
    );
  }
}
