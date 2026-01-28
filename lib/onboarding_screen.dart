import 'package:event_planning_app/providers/app_language_provider.dart';
import 'package:event_planning_app/providers/app_theme_provider.dart';
import 'package:event_planning_app/utils/app_colors.dart';
import 'package:event_planning_app/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:event_planning_app/l10n/app_localizations.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/images/appbar logo.png'),

















      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Image.asset(
                  'assets/images/being-creative.png',
                  height: 300,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                AppLocalizations.of(context)!.personalizeExperience,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: themeProvider.appTheme == ThemeMode.dark 
                      ? AppColors.whiteColor 
                      : AppColors.blackColor,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.choosePreferred,
                style: TextStyle(
                  fontSize: 16,
                  color: themeProvider.appTheme == ThemeMode.dark 
                      ? AppColors.darkGrayColor 
                      : AppColors.minGrayColor,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.theme,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: AppColors.transparentColor,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Theme.of(context).primaryColor, width: 2),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {
                            themeProvider.changeTheme(ThemeMode.light);
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.transparentColor, // Background always transparent as requested
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Icon(
                              Icons.wb_sunny,
                              color: themeProvider.appTheme == ThemeMode.light
                                  ? AppColors.lightBlueColor // Selected (Light Blue)
                                  : (themeProvider.appTheme == ThemeMode.dark 
                                      ? AppColors.whiteColor 
                                      : AppColors.minGrayColor), // Unselected
                              size: 24,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            themeProvider.changeTheme(ThemeMode.dark);
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.transparentColor, // Background always transparent as requested
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Icon(
                              Icons.nightlight_round,
                              color: themeProvider.appTheme == ThemeMode.dark
                                  ? AppColors.lightBlueColor // Selected (Light Blue)
                                  : (themeProvider.appTheme == ThemeMode.light 
                                      ? AppColors.minGrayColor 
                                      : AppColors.whiteColor), // Unselected
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                     AppLocalizations.of(context)!.language,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: AppColors.transparentColor,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Theme.of(context).primaryColor, width: 2),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {
                            languageProvider.changeLanguage('en');
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.transparentColor, // Background always transparent as requested
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                                 AppLocalizations.of(context)!.english,
                                   style: TextStyle(
                                     color: languageProvider.appLanguage == 'en'
                                         ? AppColors.lightBlueColor // Selected (Light Blue)
                                         : (themeProvider.appTheme == ThemeMode.dark 
                                             ? AppColors.whiteColor 
                                             : AppColors.minGrayColor), // Unselected
                                     fontSize: 20
                                   ),
                               ),
                          ),
                        ),
  
                        InkWell(
                          onTap: () {
                            languageProvider.changeLanguage('ar');
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.transparentColor, // Background always transparent as requested
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.arabic,
                               style: TextStyle(
                                 color: languageProvider.appLanguage == 'ar'
                                     ? AppColors.lightBlueColor // Selected (Light Blue)
                                     : (themeProvider.appTheme == ThemeMode.dark 
                                         ? AppColors.whiteColor 
                                         : AppColors.minGrayColor), // Unselected
                                 fontSize: 20
                               ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeProvider.appTheme == ThemeMode.dark
                        ? AppColors.darkBlueColor
                        : AppColors.darkBgColor,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                     Navigator.pushNamed(context, AppRoutes.introRoute);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.letsStart,
                    style: const TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
