import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'providers/app_provider.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Use FFI for Windows/Linux desktop
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

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
      routerConfig: _router,
    );
  }
}
