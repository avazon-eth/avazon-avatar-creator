import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:avarium_avatar_creator/common/utils.dart';
import 'package:avarium_avatar_creator/models/common/page_request_model.dart';
import 'package:avarium_avatar_creator/models/common/page_response_model.dart';
import 'package:easy_debounce/easy_throttle.dart';

abstract class AbstractPageNotifier<T> extends StateNotifier<List<T>> {
  PageRequestModel _pageRequestModel = const PageRequestModel();
  PageResponseModel? lastResponse;

  PageRequestModel get pageRequestModel => _pageRequestModel;
  Map<String, dynamic> get queries => pageRequestModel.toJson();
  set pageRequestModel(PageRequestModel x) {
    if (x != _pageRequestModel) {
      _pageRequestModel = x;
      refresh();
    }
  }

  bool get loading => lastResponse == null;
  bool get pagingDone => lastResponse != null && lastResponse!.items.isEmpty;

  /// Common pagination through StateNotifier
  AbstractPageNotifier({
    PageRequestModel pageRequestModel = const PageRequestModel(),
  })  : _pageRequestModel = pageRequestModel,
        super([]) {
    fetch();
  }

  /// Fetching method that child classes must implement
  Future<PageResponseModel> getList({required PageRequestModel pageRequest});

  /// Function to implement returning T from json, assigned to child classes.
  T fromJson(Map<String, dynamic> json);

  /// fetch(): Fetch more items if possible.
  Future<List<T>> fetch() async {
    // If the last response's cursor is null, there are no more items to fetch
    if (lastResponse != null && lastResponse!.items.isEmpty) {
      return [];
    }

    // Adjust request cursor
    _pageRequestModel = _pageRequestModel.copyWith(
      page: (_pageRequestModel.page ?? -1) + 1,
    );
    // Handle response
    lastResponse = await getList(pageRequest: _pageRequestModel);

    try {
      final data = lastResponse!.getData<T>(this.fromJson);
      state = [...state, ...data];
      return data;
    } catch (e) {
      Utils.d("Paging type cast error - type:$T $e");
      Utils.showErrorToast(message: "An error occurred while fetching data");
    }
    return [];
  }

  Future<List<T>> refresh({bool clear = true}) async {
    if (clear) {
      state = [];
    }
    lastResponse = null;
    _pageRequestModel = _pageRequestModel.cursorCleared;
    return state = await fetch();
  }

  void clear() {
    state = [];
    lastResponse = null;
    _pageRequestModel = const PageRequestModel();
  }
}

class PageScrollController extends ScrollController {
  /// Callback when the offset is close to maxScrollExtent
  void Function()? onEnd;

  /// Callback for the scroll direction
  void Function(ScrollDirection)? onDirection;

  /// Callback for the offset event
  void Function(double)? onOffset;

  PageScrollController({
    this.onEnd,
    this.onDirection,
    this.onOffset,
  }) {
    addListener(_throttleEvent);
  }

  void _throttleEvent() {
    EasyThrottle.throttle(
      "paging-event-$hashCode",
      const Duration(milliseconds: 300),
      _handleScrollEvent,
      onAfter: _handleScrollEvent,
    );
  }

  void _handleScrollEvent() async {
    if (!hasClients) {
      return;
    }
    if (onEnd != null) {
      if (position.maxScrollExtent - offset < 300) {
        onEnd!.call();
      }
    }
    onOffset?.call(offset);
  }

  @override
  void dispose() {
    super.dispose();
    removeListener(_throttleEvent);
  }
}
