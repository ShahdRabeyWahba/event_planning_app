 import 'package:event_planning_app/providers/app_theme_provider.dart';
import 'package:event_planning_app/utils/app_assets.dart';
import 'package:event_planning_app/utils/app_colors.dart';
import 'package:event_planning_app/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static const String routName = 'splash_screen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.onboardingRoute);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: themeProvider.appTheme == ThemeMode.dark
          ? AppColors.darkBlueColor
          : AppColors.whiteColor,
      body: Stack(
        children: [
          Center(
            child: Image.asset(AppAssets.eventlyBg,
              height: size.height * 0.10, // Further reduced from 0.15
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            bottom: size.height * 0.05, // Adjusted for better spacing
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(AppAssets.routeBg,
                height: size.height * 0.10, // Increased from 0.05 as requested
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
