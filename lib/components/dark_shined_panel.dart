import 'package:avarium_avatar_creator/common/colors.dart';
import 'package:avarium_avatar_creator/components/shined.dart';
import 'package:flutter/material.dart';

class DarkShinedPanel extends StatelessWidget {
  final Widget child;

  const DarkShinedPanel({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Opacity(
            opacity: 0.2,
            child: Shined(
              backgroundColor: ColorTable.greyTransparent,
              borderRadius: 24,
              borderWidth: 1,
              padding: EdgeInsets.zero,
              child: Container(),
            ),
          ),
        ),
        child,
      ],
    );
  }
}
