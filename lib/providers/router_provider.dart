import 'package:avarium_avatar_creator/screens/avatar_creation_screen.dart';
import 'package:avarium_avatar_creator/screens/avatar_video_creation_screen.dart';
import 'package:avarium_avatar_creator/screens/avatar_video_with_image_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/avatar/:avatarId/contents/video/create/:token_key',
        name: AvatarCreateVideoScreen.routeName,
        builder: (context, state) => AvatarCreateVideoScreen(
          avatarId: state.pathParameters['avatarId'] ?? '',
          tokenKey: state.pathParameters['token_key'] ?? '',
        ),
      ),
      GoRoute(
        path: '/avatar/:avatarId/contents/video/create/:creationId',
        name: AvatarCreateVideoWithImageScreen.routeName,
        builder: (context, state) => AvatarCreateVideoWithImageScreen(
          avatarId: state.pathParameters['avatarId'] ?? '',
          videoCreationId: state.pathParameters['creationId'] ?? '',
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
