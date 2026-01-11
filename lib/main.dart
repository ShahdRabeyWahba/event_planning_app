import 'package:event_planning_app/onboarding_screen.dart';
import 'package:event_planning_app/splash_screen.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'intro_screen.dart';
import 'utils/app_routes.dart';

void main() {
  runApp(MyApp() );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splashRoute,
      routes: {
        AppRoutes.homescreenRoute: (context) => HomeScreen(),
        AppRoutes.introRoute: (context) => IntroScreen(),
        AppRoutes.splashRoute: (context) => SplashScreen(),
        AppRoutes.onboardingRoute: (context) => const OnboardingScreen(),
      },
      themeMode: ThemeMode.dark,
    );
  }
}