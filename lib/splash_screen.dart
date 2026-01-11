 import 'package:event_planning_app/utils/app_assets.dart';
import 'package:event_planning_app/utils/app_colors.dart';
import 'package:event_planning_app/utils/app_routes.dart';
import 'package:flutter/material.dart';

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
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:AppColors.whiteColor,
      body: Stack(
        children: [
          Center(
            child: Image.asset(AppAssets.logoBg,
              height: size.height * 0.25,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(AppAssets.routeBg,
                height: size.height * 0.15, 
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
