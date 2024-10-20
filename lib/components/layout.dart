import 'package:avarium_avatar_creator/consts/colors.dart';
import 'package:flutter/material.dart';

class AvatarLayout extends StatelessWidget {
  final Widget avatar;
  final Widget panel;

  const AvatarLayout({
    super.key,
    required this.avatar,
    required this.panel,
  });

  @override
  Widget build(BuildContext context) {
    bool fold = MediaQuery.of(context).size.width < 768;
    return Scaffold(
      backgroundColor: GidColorTable.systemBlack3,
      body: Column(
        children: [
          if (!fold)
            Expanded(
              child: Row(
                children: [
                  Expanded(child: avatar),
                  Expanded(child: panel),
                ],
              ),
            ),
          if (fold)
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: avatar,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: panel,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
