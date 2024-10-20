import 'package:avarium_avatar_creator/screens/avatar_creation_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
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
