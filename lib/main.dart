import 'package:event_planning_app/firebase_options.dart';
import 'package:event_planning_app/onboarding_screen.dart';
import 'package:event_planning_app/providers/app_language_provider.dart';
import 'package:event_planning_app/providers/app_theme_provider.dart';
import 'package:event_planning_app/providers/favorite_provider.dart';
import 'package:event_planning_app/providers/user_provider.dart';
import 'package:event_planning_app/splash_screen.dart';
import 'package:event_planning_app/tabes/Login_tab.dart';
import 'package:event_planning_app/tabes/forget_password_tab.dart';
import 'package:event_planning_app/tabes/register_tab.dart';
import 'package:event_planning_app/utils/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart';
import 'home_screen.dart';
import 'intro_screen.dart';
import 'screens/add_event_screen.dart';
import 'screens/edit_event_screen.dart';
import 'screens/event_details_screen.dart';
import 'utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MultiProvider(
      providers: [
    ChangeNotifierProvider(create: (context) => AppLanguageProvider()),
    ChangeNotifierProvider(create: (context) => AppThemeProvider()),
    ChangeNotifierProvider(create: (context) => FavoriteProvider()),
    ChangeNotifierProvider(create: (context) => UserProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splashRoute,
      routes: {
        AppRoutes.homescreenRoute: (context) => HomeScreen(),
        AppRoutes.introRoute: (context) => IntroScreen(),
        AppRoutes.splashRoute: (context) => SplashScreen(),
        AppRoutes.onboardingRoute: (context) => OnboardingScreen(),
        AppRoutes.loginRoute: (context) => LoginTab(),
        AppRoutes.registerRoute: (context) => RegisterTab(),
        AppRoutes.forgetPasswordRoute: (context) => ForgetPasswordTab(),
        AppRoutes.addEventRoute: (context) => const AddEventScreen(),
        AppRoutes.editEventRoute: (context) => const EditEventScreen(),
        AppRoutes.eventDetailsRoute: (context) => const EventDetailsScreen(),
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(languageProvider.appLanguage),
      themeMode: themeProvider.appTheme,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
    );
  }
}