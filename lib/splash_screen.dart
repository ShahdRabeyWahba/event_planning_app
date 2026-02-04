import 'package:event_planning_app/Firebase_utils.dart';
import 'package:event_planning_app/providers/app_theme_provider.dart';
import 'package:event_planning_app/providers/user_provider.dart';
import 'package:event_planning_app/utils/app_assets.dart';
import 'package:event_planning_app/utils/app_colors.dart';
import 'package:event_planning_app/utils/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    Future.delayed(const Duration(seconds: 3), () async {
      if (mounted) {
        var user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          var myUser = await FirebaseUtils.readUserFromFirestore(user.uid);
          if (mounted) {
            var userProvider = Provider.of<UserProvider>(context, listen: false);
            userProvider.updateUser(myUser);
            Navigator.pushReplacementNamed(context, AppRoutes.homescreenRoute);
          }
        } else {
          Navigator.pushReplacementNamed(context, AppRoutes.onboardingRoute);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: themeProvider.isDarkMode()
          ? AppColors.darkBackgroundColor
          : AppColors.whiteColor,
      body: Stack(
        children: [
          Center(
            child: Image.asset(AppAssets.eventlyBg,
              height: size.height * 0.05, // Further reduced as requested
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            bottom: size.height * 0.06, // Increased bottom spacing
            left: 0,
            right: 0,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0), // Spacing from sides
                child: Image.asset(AppAssets.routeBg,
                  height: size.height * 0.06, // Minimized size as requested
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
