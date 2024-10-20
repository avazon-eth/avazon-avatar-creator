import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:avarium_avatar_creator/common/colors.dart';
import 'package:avarium_avatar_creator/providers/router_provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Avazon Avatar Creator',
      debugShowCheckedModeBanner: false,
      supportedLocales: const [
        Locale('en', 'US'),
      ],
      routerConfig: router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: ColorTable.primary,
          brightness: Brightness.dark,
        ),
        fontFamily: 'Poppins',
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 32,
            height: 1.25,
          ),
          displayMedium: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w800,
            fontSize: 28,
            height: 1.25,
          ),
          displaySmall: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 24,
            height: 1.25,
          ),
          headlineMedium: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
            height: 1.25,
          ),
          headlineSmall: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 18,
            height: 1.25,
          ),
          titleLarge: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 24,
            height: 1.25,
          ),
          bodyLarge: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 16,
            height: 1.25,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 14,
            height: 1.25,
          ),
          labelSmall: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 12,
            height: 1.25,
          ),
        ),
        tabBarTheme: const TabBarTheme(
          indicatorColor: ColorTable.white,
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: ColorTable.greyTransparent,
          labelStyle: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 18,
            height: 1.25,
            color: ColorTable.white,
          ),
          labelColor: ColorTable.white,
          unselectedLabelStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            height: 1.25,
            color: ColorTable.grey,
          ),
        ),
        useMaterial3: true,
      ),
    );
  }
}
