import 'package:event_planning_app/Firebase_utils.dart';
import 'package:event_planning_app/l10n/app_localizations.dart';
import 'package:event_planning_app/language/language_bottom_sheet.dart';
import 'package:event_planning_app/providers/app_language_provider.dart';
import 'package:event_planning_app/providers/app_theme_provider.dart';
import 'package:event_planning_app/providers/user_provider.dart';
import 'package:event_planning_app/theme/theme_bottom_sheet.dart';
import 'package:event_planning_app/utils/app_colors.dart';
import 'package:event_planning_app/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  //todo: language => language , english , arabic
  String? language;
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    var localizations = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 60),
          Center(
            child: Column(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(
                    color: AppColors.darkBgColor,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("assets/images/Profike pic.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  userProvider.currentUser?.name ?? "Guest",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: themeProvider.isDarkMode()
                        ? AppColors.whiteColor
                        : AppColors.blackColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  userProvider.currentUser?.email ?? "",
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.darkGrayColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                _buildSettingsTile(
                  context,
                  title: localizations.darkMode,
                  trailing: Switch(
                    value: themeProvider.isDarkMode(),
                    activeThumbColor: AppColors.whiteColor,
                    activeTrackColor: AppColors.lightBlueColor,
                    onChanged: (value) {
                      themeProvider.changeTheme(
                        value ? ThemeMode.dark : ThemeMode.light,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                _buildSettingsTile(
                  context,
                  title: localizations.language,
                  subtitle: languageProvider.appLanguage == "en"
                      ? localizations.english
                      : localizations.arabic,
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: themeProvider.isDarkMode()
                        ? AppColors.whiteColor
                        : AppColors.blackColor,
                    size: 16,
                  ),
                  onTap: () => showLanguageBottomSheet(),
                ),
                const SizedBox(height: 16),
                _buildSettingsTile(
                  context,
                  title: localizations.logout,
                  isLogout: true,
                  trailing: const Icon(
                    Icons.logout,
                    color: AppColors.redColor,
                    size: 20,
                  ),
                  onTap: () async {
                    await FirebaseUtils.logout();
                    if (mounted) {
                      userProvider.updateUser(null);
                      Navigator.pushReplacementNamed(
                          context, AppRoutes.splashRoute);
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(BuildContext context,
      {required String title,
      String? subtitle,
      required Widget trailing,
      VoidCallback? onTap,
      bool isLogout = false}) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: themeProvider.isDarkMode()
              ? AppColors.darkBackgroundColor
              : AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: themeProvider.isDarkMode()
                ? AppColors.lightBlueColor
                : AppColors.grayColor,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: themeProvider.isDarkMode()
                          ? AppColors.whiteColor
                          : AppColors.blackColor,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: themeProvider.isDarkMode()
                            ? AppColors.whiteColor
                            : AppColors.darkGrayColor,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const LanguageBottomSheet(),
    );
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const ThemeBottomSheet(),
    );
  }
}
