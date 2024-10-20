import 'package:avarium_avatar_creator/common/utils.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod/riverpod.dart';

final secretStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );
});

final secretValueProvider =
    StateNotifierProviderFamily<SecretValueStateNotifier, String?, String>(
  (ref, key) => SecretValueStateNotifier(
      storage: ref.read(secretStorageProvider), key: key),
);

class SecretValueStateNotifier extends StateNotifier<String?> {
  final FlutterSecureStorage storage;
  final String key;

  SecretValueStateNotifier({required this.storage, required this.key})
      : super(null) {
    fetch();
  }

  Future<String?> fetch() async {
    try {
      return state = await storage.read(key: key);
    } catch (e) {
      Utils.d('SecretValueStateNotifier error : $e');
      storage.deleteAll();
      return null;
    }
  }

  Future<String?> fetchIfNull() async {
    if (state == null) {
      return fetch();
    }

    return state;
  }

  Future<void> save(String value) async {
    try {
      await storage.write(key: key, value: value);
      state = value;
    } catch (e) {
      Utils.d('SecretValueStateNotifier save error : $e');
      storage.deleteAll();
      state = null;
    }
  }

  Future<void> clear() async {
    try {
      await storage.delete(key: key);
    } catch (e) {
      Utils.d('SecretValueStateNotifier clear error : $e');
      storage.deleteAll();
    }
  }
}
