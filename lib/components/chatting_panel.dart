import 'package:avarium_avatar_creator/common/colors.dart';
import 'package:flutter/material.dart';

class ChattingModel {
  final bool isMine; // otherwise, other
  final String message;

  const ChattingModel({
    required this.isMine,
    required this.message,
  });
}

class ChattingBox extends StatelessWidget {
  final Widget? icon;
  final bool isMine;
  final String message;

  const ChattingBox({
    super.key,
    this.icon,
    required this.isMine,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (icon != null && !isMine)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: icon!,
            ),
          Flexible(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 440),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: isMine ? ColorTable.greyTransparent : Colors.transparent,
                borderRadius: BorderRadius.circular(18.0),
                border: Border.all(
                  width: 1.0,
                  color: isMine ? Colors.transparent : ColorTable.grey,
                ),
              ),
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 15.0,
                  height: 1.25,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChattingScroll extends StatefulWidget {
  final Widget? otherIcon; // other user's icon
  final List<ChattingModel> items;
  final Stream<String>? messageStream; // other user's message on generating

  const ChattingScroll({
    this.otherIcon,
    required this.items,
    this.messageStream,
    super.key,
  });

  @override
  State<ChattingScroll> createState() => _ChattingScrollState();
}

class _ChattingScrollState extends State<ChattingScroll> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    // scroll to bottom
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      while (_controller.position.maxScrollExtent - _controller.offset > 100) {
        await _controller.animateTo(
          _controller.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: StreamBuilder<String>(
        stream: widget.messageStream,
        builder: (context, snapshot) {
          int itemCount =
              widget.items.length + (widget.messageStream != null ? 1 : 0);
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            controller: _controller,
            itemCount: itemCount,
            itemBuilder: (context, index) {
              if (index == itemCount - 1 && widget.messageStream != null) {
                if (snapshot.connectionState == ConnectionState.active &&
                    snapshot.hasData &&
                    (snapshot.data?.isNotEmpty ?? false)) {
                  // scroll to bottom
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _controller.animateTo(
                      _controller.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  });
                  return ChattingBox(
                    isMine: false,
                    message: snapshot.data ?? '',
                    icon: widget.otherIcon,
                  );
                }
                return const SizedBox.shrink();
              }
              final item = widget.items[index];
              return ChattingBox(
                isMine: item.isMine,
                message: item.message,
                icon: widget.otherIcon,
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
