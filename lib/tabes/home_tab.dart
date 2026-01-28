import 'package:event_planning_app/l10n/app_localizations.dart';
import 'package:event_planning_app/language/language_bottom_sheet.dart';
import 'package:event_planning_app/providers/app_language_provider.dart';
import 'package:event_planning_app/providers/app_theme_provider.dart';
import 'package:event_planning_app/providers/favorite_provider.dart';
import 'package:event_planning_app/utils/app_colors.dart';
import 'package:event_planning_app/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context)!;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var languageProvider = Provider.of<AppLanguageProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.isDarkMode()
          ? AppColors.darkBackgroundColor
          : AppColors.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: themeProvider.isDarkMode()
            ? AppColors.darkBackgroundColor
            : AppColors.whiteColor, // White AppBar in Light Mode
        toolbarHeight: 120,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localizations.welcomeBack,
                        style: TextStyle(
                          color: themeProvider.isDarkMode()
                              ? AppColors.whiteColor
                              : AppColors.darkGrayColor, // Grey in Light Mode
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "John Safwat",
                        style: TextStyle(
                          color: themeProvider.isDarkMode()
                              ? AppColors.whiteColor
                              : Colors.black, // Black in Light Mode
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          themeProvider.changeTheme(
                            themeProvider.isDarkMode()
                                ? ThemeMode.light
                                : ThemeMode.dark,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: themeProvider.isDarkMode() ? AppColors.lightBlueColor : AppColors.darkBgColor,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            themeProvider.isDarkMode()
                                ? Icons.nightlight_round
                                : Icons.wb_sunny_outlined,
                            color: themeProvider.isDarkMode()
                                ? AppColors.whiteColor
                                : AppColors.darkBgColor,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () {
                          showLanguageBottomSheet();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: themeProvider.isDarkMode() ? AppColors.lightBlueColor : AppColors.darkBgColor,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.transparent,
                          ),
                          child: Text(
                            languageProvider.appLanguage.toUpperCase(),
                            style: TextStyle(
                              color: themeProvider.isDarkMode()
                                  ? AppColors.lightBlueColor
                                  : AppColors.darkBgColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(), // Force scrollable
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildCategoryItem(0, localizations.all, Icons.grid_view),
                  _buildCategoryItem(1, localizations.sport, Icons.directions_bike),
                  _buildCategoryItem(2, localizations.birthday, Icons.cake_outlined),
                  _buildCategoryItem(3, localizations.meeting, Icons.groups_outlined),
                  _buildCategoryItem(4, localizations.bookClub, Icons.menu_book),
                  _buildCategoryItem(5, "Holiday", Icons.beach_access),
                  _buildCategoryItem(6, "Exhibition", Icons.palette_outlined),
                  _buildCategoryItem(7, "Gaming", Icons.gamepad_outlined),
                  _buildCategoryItem(8, "Workshop", Icons.work_outline),
                  _buildCategoryItem(9, "Concert", Icons.music_note_outlined),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            _buildEventCard(
              context,
              localizations.jan21,
              "Birthday",
              localizations.birthdayDesc,
              "assets/images/Birthday.png",
            ),
            _buildEventCard(
              context,
              localizations.jan22,
              "Meeting",
              localizations.meetingDesc,
              "assets/images/Meeting.png",
            ),
            _buildEventCard(
              context,
              localizations.jan23,
              "Exhibition",
              localizations.exhibitionDesc,
              "assets/images/Exhibition.png",
            ),
            _buildEventCard(
              context,
              localizations.jan24,
              "Sport",
              localizations.sport,
              "assets/images/Sport.png",
            ),
            _buildEventCard(
              context,
              localizations.jan25,
              "Sport",
              localizations.bookClub,
              "assets/images/Book Club.png",
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(int index, String title, IconData icon) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    bool isDark = themeProvider.isDarkMode();
    bool isSelected = selectedCategoryIndex == index;

    // Matching image for both modes: Blue themes
    Color selectedBgColor = isDark ? AppColors.lightBlueColor : AppColors.darkBgColor;
    
    // Separate colors for icon and text as requested
    Color iconColor = isSelected ? AppColors.whiteColor : (isDark ? AppColors.lightBlueColor : Colors.black);
    Color textColor = isSelected ? AppColors.whiteColor : (isDark ? AppColors.whiteColor : Colors.black);
    
    Color borderColor = isDark ? AppColors.lightBlueColor : AppColors.darkBgColor;

    return InkWell(
      onTap: () {
        setState(() {
          selectedCategoryIndex = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? selectedBgColor : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 22,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventCard(BuildContext context, String date, String title, String desc, String imagePath) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    bool isDark = themeProvider.isDarkMode();

    // Color Refinements
    Color themeBlue = isDark ? AppColors.lightBlueColor : AppColors.darkBgColor;
    Border? cardBorder = Border.all(color: themeBlue, width: 1.2);
    
    // Date Box: Background matches app background, Blue text
    Color dateBgColor = isDark ? AppColors.darkBackgroundColor : AppColors.whiteColor;
    Color dateTextColor = themeBlue;

    // Dynamic Image path for Dark Mode
    String finalImagePath = isDark 
        ? imagePath.replaceAll('.png', ' dark.png') 
        : imagePath;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: cardBorder,
        image: DecorationImage(
          image: AssetImage(finalImagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.eventDetailsRoute);
        },
        child: Stack(
          children: [
            Positioned(
            top: 12,
            left: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: dateBgColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                date,
                style: TextStyle(
                  color: dateTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkBackgroundColor.withOpacity(0.9) : AppColors.whiteColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      desc,
                      style: TextStyle(
                        color: isDark ? AppColors.whiteColor : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Consumer<FavoriteProvider>(
                    builder: (context, favProvider, child) {
                      bool isFavorite = favProvider.isFavorite(title);
                      return InkWell(
                        onTap: () {
                          favProvider.toggleFavorite(title);
                        },
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: themeBlue,
                          size: 24,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
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
}
