import 'package:avarium_avatar_creator/screens/avatar_creation_screen.dart';
import 'package:avarium_avatar_creator/screens/avatar_video_creation_screen.dart';
import 'package:avarium_avatar_creator/screens/avatar_video_with_image_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/avatar/:avatar_id/contents/video/create/start/:token_key',
        name: AvatarCreateVideoScreen.routeName,
        builder: (context, state) => AvatarCreateVideoScreen(
          avatarId: state.pathParameters['avatar_id'] ?? '',
          tokenKey: state.pathParameters['token_key'] ?? '',
        ),
      ),
      GoRoute(
        path: '/avatar/:avatar_id/contents/video/:creation_id/create',
        name: AvatarCreateVideoWithImageScreen.routeName,
        builder: (context, state) => AvatarCreateVideoWithImageScreen(
          avatarId: state.pathParameters['avatar_id'] ?? '',
          videoCreationId: state.pathParameters['creation_id'] ?? '',
        ),
      ),
      // avatar creation
      GoRoute(
        path: '/:token_key',
        name: AvatarCreationScreen.routeName,
        builder: (context, state) => AvatarCreationScreen(
          tokenKey: state.pathParameters['token_key'] ?? '',
        ),
      ),
    ],
  );
});
