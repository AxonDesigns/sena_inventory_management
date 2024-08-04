import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:sena_inventory_management/core/config/app_theme.dart';
import 'package:sena_inventory_management/presentation/presentation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'presentation/providers/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences preferences = await SharedPreferences.getInstance();

  int themeMode = preferences.getInt("theme_mode") ?? 0;
  await preferences.setInt("theme_mode", themeMode);

  final store = AsyncAuthStore(
    save: (String data) async => await preferences.setString('pb_auth', data),
    initial: preferences.getString('pb_auth'),
  );

  runApp(ProviderScope(
    overrides: [
      themeModeProvider.overrideWith(
        (ref) => ThemeModeNotifier.define(ThemeMode.values[themeMode]),
      ),
      pocketBaseProvider.overrideWith(
        (ref) => PocketBase("http://localhost:8090", authStore: store),
      ),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(themeModeProvider).themeMode;

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: AppTheme.theme(false),
      darkTheme: AppTheme.theme(true),
      routerConfig: router,
    );
  }
}
