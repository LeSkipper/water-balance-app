import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'providers/app_provider.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => AppProvider(),
      child: const WaterBalanceApp(),
    ),
  );
}

class WaterBalanceApp extends StatefulWidget {
  const WaterBalanceApp({super.key});

  @override
  State<WaterBalanceApp> createState() => _WaterBalanceAppState();
}

class _WaterBalanceAppState extends State<WaterBalanceApp> {
  late final _router;

  @override
  void initState() {
    super.initState();
    final provider = context.read<AppProvider>();
    _router = createRouter(provider);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();

    return MaterialApp.router(
      title: 'Water Balance',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: provider.themeMode,
      locale: provider.locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ru'),
        Locale('es'),
        Locale('fr'),
        Locale('de'),
      ],
      routerConfig: _router,
    );
  }
}
