import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class AbstractObjectNotifier<T> extends StateNotifier<T?> {
  DateTime? _lastFetch;

  /// Internal field filled during fetch() to prevent duplicate calls.
  Future<T>? _fetchingCbk;

  DateTime? get lastFetch => _lastFetch;

  T? get data => state;

  set data(T? obj) {
    state = obj;
    onState(obj);
  }

  /// Common provider for a single data item.
  AbstractObjectNotifier() : super(null);

  /* abstract method START */

  /// Callback executed after the state changes
  /// Can implement state propagation between providers, etc.
  void onState(T? obj);

  /// Delegates the function to fetch data to child classes.
  Future<T> getData();

  /* abstract method END */

  /// Has [duration] time passed since the last fetch?
  /// Returns false if there is no fetch history.
  bool isAfter({Duration duration = const Duration(minutes: 1)}) {
    if (lastFetch == null) {
      return false;
    }
    return DateTime.now().difference(lastFetch!).compareTo(duration) > 0;
  }

  Future<T> fetch() async {
    if (_fetchingCbk != null) {
      return _fetchingCbk!;
    }
    final data = await (_fetchingCbk = getData());
    // set state
    this.data = data;
    _lastFetch = DateTime.now();
    // End fetching process
    _fetchingCbk = null;
    return data;
  }

  /// clear: whether to execute state = null
  Future<T> refresh({bool clear = true}) async {
    if (clear) {
      state = null;
    }
    _lastFetch = null;
    return fetch();
  }

  /// duration: Calls refresh() after [duration] time has passed.
  /// clear: whether to execute state = null
  Future<T> refreshIf({
    Duration duration = const Duration(minutes: 1),
    bool clear = true,
  }) async {
    if (state == null || lastFetch == null || isAfter(duration: duration)) {
      return await refresh(clear: clear);
    }
    return state!;
  }
}
