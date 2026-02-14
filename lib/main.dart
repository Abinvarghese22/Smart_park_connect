import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'providers/app_provider.dart';
import 'screens/splash/splash_screen.dart';

/// Smart Park Connect - Intelligent Parking Management System
/// Entry point of the application
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations to portrait only
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set system UI overlay style for status bar
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  runApp(const SmartParkConnectApp());
}

/// Root widget of the application
/// Wraps the app with Provider for state management
class SmartParkConnectApp extends StatelessWidget {
  const SmartParkConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppProvider(),
      child: Consumer<AppProvider>(
        builder: (context, appProvider, _) {
          return MaterialApp(
            title: 'Smart Park Connect',
            debugShowCheckedModeBanner: false,
            // Theme configuration
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: appProvider.themeMode,
            // Start with splash screen
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
