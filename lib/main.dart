import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dfei_opus/app.dart';

/// Entry point for the DFEI application.
///
/// Initializes Flutter bindings, locks orientation to portrait,
/// sets system UI overlay style for the tactical dark theme,
/// and launches the app inside a Riverpod [ProviderScope].
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock to portrait for field use.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Dark system UI overlays.
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF000000),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(
    const ProviderScope(
      child: DfeiApp(),
    ),
  );
}
