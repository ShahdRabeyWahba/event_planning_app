import 'package:event_planning_app/l10n/app_localizations.dart';
import 'package:event_planning_app/providers/app_theme_provider.dart';
import 'package:event_planning_app/providers/favorite_provider.dart';
import 'package:event_planning_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context)!;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    bool isDark = themeProvider.isDarkMode();

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackgroundColor : AppColors.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 80,
        title: TextField(
          textAlign: TextAlign.left,
          style: TextStyle(color: isDark ? AppColors.whiteColor : AppColors.darkBgColor),
          decoration: InputDecoration(
            hintText: localizations.searchForEvent,
            hintStyle: TextStyle(
              color: isDark ? AppColors.whiteColor : AppColors.darkBgColor,
            ),
            suffixIcon: Icon(
              Icons.search,
              color: isDark ? AppColors.lightBlueColor : AppColors.darkBgColor,
              size: 28,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: isDark ? AppColors.lightBlueColor : AppColors.darkBgColor,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: isDark ? AppColors.lightBlueColor : AppColors.darkBgColor,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
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
                color: isDark ? AppColors.darkBackgroundColor : AppColors.whiteColor,
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
    );
  }
}
