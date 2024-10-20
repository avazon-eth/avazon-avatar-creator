import 'package:avarium_avatar_creator/components/icons.dart';
import 'package:avarium_avatar_creator/common/colors.dart';
import 'package:flutter/material.dart';

// indicator for creation of new content
// stateful for status in progress
class AvatarCreationIndicator extends StatelessWidget {
  /// 1: ready, 2: in progress, 3: completed, 4: failed
  final int progress;
  final int waitingSeconds; // for in progress (Default 10 seconds)

  const AvatarCreationIndicator({
    super.key,
    required this.progress,
    this.waitingSeconds = 10,
  });

  @override
  Widget build(BuildContext context) {
    if (progress == 2) {
      return GidCreationInProgressIndicator(waitingSeconds: waitingSeconds);
    } else if (progress == 3) {
      return const SvgIcon(iconPath: IconPath.purpleCheck);
    } else if (progress == 4) {
      return const Icon(
        Icons.error,
        color: ColorTable.grey,
        size: 16.0,
      );
    }

    // simple white dot
    return const Icon(
      Icons.circle,
      size: 8.0,
    );
  }
}

class GidCreationInProgressIndicator extends StatefulWidget {
  final int waitingSeconds;

  const GidCreationInProgressIndicator({
    super.key,
    this.waitingSeconds = 10,
  });

  @override
  State<GidCreationInProgressIndicator> createState() =>
      _GidCreationInProgressIndicatorState();
}

class _GidCreationInProgressIndicatorState
    extends State<GidCreationInProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: widget.waitingSeconds),
      vsync: this,
    )..forward();

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Center(
          child: CircularProgressIndicator(
            value: _animation.value,
            color: ColorTable.purpleGradient1,
            backgroundColor: ColorTable.grey,
          ),
        );
      },
    );
  }
}
