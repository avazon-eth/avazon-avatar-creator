import 'package:avarium_avatar_creator/consts/colors.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GidColorTable.systemBlack3,
    );
  }
}
