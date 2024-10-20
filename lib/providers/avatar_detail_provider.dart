import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:avarium_avatar_creator/models/avatar_model.dart';
import 'package:avarium_avatar_creator/providers/common/abstract_object_provider.dart';
import 'package:avarium_avatar_creator/repository/avatar_repository.dart';

final avatarDetailProvider = StateNotifierProviderFamily<
    AvatarDetailStateNotifier, AvatarModel?, String>(
  (ref, avatarId) => AvatarDetailStateNotifier(
    avatarRepository: ref.watch(avatarRepositoryProvider),
    avatarId: avatarId,
  ),
);

class AvatarDetailStateNotifier extends AbstractObjectNotifier<AvatarModel> {
  final AvatarRepository avatarRepository;
  final String avatarId;

  AvatarDetailStateNotifier({
    required this.avatarRepository,
    required this.avatarId,
  }) {
    fetch();
  }

  @override
  Future<AvatarModel> getData() async {
    return await avatarRepository.getAvatar(avatarId);
  }

  @override
  void onState(AvatarModel? obj) {
    // TODO: implement onState
  }
}
