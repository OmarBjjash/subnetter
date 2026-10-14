import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'app.dart';
import 'core/di/injection.dart';

Future<void> main() async {
  // 1. Correctly initialize bindings first
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // 2. Keep the native splash visible
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // 3. DO YOUR INITIALIZATION HERE (Dependency Injection) while the user waits
  await setupDI();

  // 4. Wait for the remainder of your 3-second delay
  await Future.delayed(const Duration(milliseconds: 1300));

  // 5. Remove the splash and run the app
  FlutterNativeSplash.remove();
  runApp(const SubnetterApp());
}
