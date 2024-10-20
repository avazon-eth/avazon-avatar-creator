import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

abstract class IconPath {
  static const base = 'assets/icons';
  static const search = '$base/search.svg';
  static const notification = '$base/notification.svg';
  static const thumbsup = '$base/thumbsup.svg';
  static const chat = '$base/chat.svg';
  static const flight = '$base/flight.svg';
  static const play = '$base/play.svg';
  static const homeOn = '$base/home_on.svg';
  static const homeOff = '$base/home_off.svg';
  static const marketOn = '$base/market_on.svg';
  static const marketOff = '$base/market_off.svg';
  static const circlePlus = '$base/circle_plus.svg';
  static const chatOn = '$base/chat_on.svg';
  static const chatOff = '$base/chat_off.svg';
  static const profileOn = '$base/profile_on.svg';
  static const profileOff = '$base/profile_off.svg';
  static const eye = '$base/eye_icon.svg';
  static const shortcut = '$base/shortcut_icon.svg';
  static const x = '$base/x.svg';
  static const likeOff = '$base/like_off.svg';
  static const likeOn = '$base/like_on.svg';
  static const dm = '$base/dm.svg';
  static const dmFilled = '$base/dm_filled.svg';
  static const pause = '$base/pause.svg';
  static const playlist = '$base/playlist.svg';
  static const avatarCreate = '$base/avatar_create.svg';
  static const purpleCheck = '$base/purple_check.svg';
  static const gidAssistant = '$base/gid_assistant.svg';
  static const sendChat = '$base/send_chat.svg';
  static const audioWave = '$base/audio_wave.svg';
}

class SvgIcon extends StatelessWidget {
  final String iconPath;
  final double? width;
  final double? height;
  final Color? color;

  const SvgIcon({
    required this.iconPath,
    this.width,
    this.height,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      iconPath,
      width: width,
      height: height,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}
