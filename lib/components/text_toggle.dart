import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:avarium_avatar_creator/common/colors.dart';
import 'package:avarium_avatar_creator/components/shined.dart';
import 'package:flutter/material.dart';

class TextToggle extends StatelessWidget {
  final String current;
  final List<String> values;
  final void Function(String) onChanged;
  final double borderRadius;

  const TextToggle({
    super.key,
    required this.current,
    required this.values,
    required this.onChanged,
    this.borderRadius = 100.0,
  });

  @override
  Widget build(BuildContext context) {
    return Shined(
      borderRadius: borderRadius,
      padding: EdgeInsets.zero,
      child: AnimatedToggleSwitch<String>.size(
        textDirection: TextDirection.ltr,
        current: current,
        values: values,
        iconOpacity: 0.6,
        selectedIconScale: 1.0,
        indicatorSize: const Size.fromWidth(70),
        iconBuilder: (x) => Text(
          x,
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.white,
            height: 1.25,
            fontWeight: FontWeight.bold,
          ),
        ),
        borderWidth: 1.0,
        iconAnimationType: AnimationType.onHover,
        style: ToggleStyle(
          backgroundColor: ColorTable.greyTransparent,
          borderColor: Colors.transparent,
          borderRadius: BorderRadius.circular(borderRadius),
          indicatorGradient: ColorTable.purpleGradient45,
        ),
        // styleBuilder: (i) => ToggleStyle(indicatorColor: colorBuilder(i)),
        onChanged: onChanged,
      ),
    );
  }
}
