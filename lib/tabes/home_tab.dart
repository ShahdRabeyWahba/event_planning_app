import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planning_app/Firebase_utils.dart';
import 'package:event_planning_app/models/event.dart';
import 'package:event_planning_app/l10n/app_localizations.dart';
import 'package:event_planning_app/language/language_bottom_sheet.dart';
import 'package:event_planning_app/providers/app_language_provider.dart';
import 'package:event_planning_app/providers/app_theme_provider.dart';
import 'package:event_planning_app/providers/user_provider.dart';
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
    var userProvider = Provider.of<UserProvider>(context);

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
                              : AppColors.blackColor, // Changed from darkGrayColor to blackColor
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        userProvider.currentUser?.name ?? "Guest",
                        style: TextStyle(
                          color: themeProvider.isDarkMode()
                              ? AppColors.whiteColor
                              : AppColors.blackColor, // Changed from Colors.black to AppColors.blackColor
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
                            color: AppColors.lightBlueColor,
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
      body: StreamBuilder<QuerySnapshot<Event>>(
        stream: FirebaseUtils.getEventCollection().snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
             return Center(child: Text("Something went wrong"));
          }
          var events = snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
          
          // Filter by Category
          // 0 is "All" in the buildCategoryItem list.
          // CATEGORY NAMES in the ADD screen: [Book Club, Sport, Birthday, Meeting, Exhibition, Holiday, Workshop, Eating]
          // CATEGORY NAMES in the HOME Tab: [All, Sport, Birthday, Meeting, Book Club, Holiday, Exhibition, Gaming, Workshop, Concert]
          // !!! IMPORTANT: The category names and indices might not match perfectly between arrays.
          // Better to filter by String name if the user selects a category.
          
          List<String> homeCategories = [
             localizations.all, // 0
             localizations.sport, // 1
             localizations.birthday, // 2
             localizations.meeting, // 3
             localizations.bookClub, // 4
             "Holiday", // 5
             "Exhibition", // 6
             "Gaming", // 7
             "Workshop", // 8
             "Concert" // 9
          ];
          
          // Map Home Tab Index to Category Sting stored in FireStore
          // Note: Add Screen Categories: [Book Club, Sport, Birthday, Meeting,          // MARK: CATEGORY FILTERING LOGIC START
           if (selectedCategoryIndex != 0) {
              String selectedCategoryName = homeCategories[selectedCategoryIndex];
              // Handle translation discrepancies or just simple string match
              // Assuming stored category string matches 'selectedCategoryName'
              events = events.where((element) => element.category == selectedCategoryName).toList();
           }
          // MARK: CATEGORY FILTERING LOGIC END

          // Sort by Date (and Time if possible, but date is String dd/MM/yyyy)
          // Ideally date should be Timestamp, but logic currently uses String. 
          // Simple string sort might fail for dates.
          // Let's try to parse for sorting using a custom comparator.
           events.sort((a, b) {
              // Parse 'dd/MM/yyyy'
              try {
                List<String> aParts = a.date.split('/');
                List<String> bParts = b.date.split('/');
                DateTime aDate = DateTime(int.parse(aParts[2]), int.parse(aParts[1]), int.parse(aParts[0]));
                DateTime bDate = DateTime(int.parse(bParts[2]), int.parse(bParts[1]), int.parse(bParts[0]));
                return aDate.compareTo(bDate);
              } catch (e) {
                return 0;
              }
           });

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: events.length,
            itemBuilder: (context, index) {
              return _buildEventCard(
                context,
                events[index],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildCategoryItem(int index, String title, IconData icon) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    bool isDark = themeProvider.isDarkMode();
    bool isSelected = selectedCategoryIndex == index;

    // Matching image for both modes: Blue themes
    Color selectedBgColor = isDark ? AppColors.lightBlueColor : AppColors.darkBgColor;
    
    // Unified Blue theme for unselected items in ALL modes
    Color iconColor = isSelected ? AppColors.whiteColor : AppColors.lightBlueColor;
    Color textColor = isSelected ? AppColors.whiteColor : (isDark ? AppColors.whiteColor : AppColors.blackColor);
    Color borderColor = isSelected ? (isDark ? AppColors.lightBlueColor : AppColors.darkBgColor) : AppColors.lightBlueColor;

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

  Widget _buildEventCard(BuildContext context, Event event) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    bool isDark = themeProvider.isDarkMode();
    
    // Extract data
    // Extract data
    String date = event.date; 
    String title = event.title;
    // String desc = event.description; // Not used in card summary to save space/avoid clutter, or we can add it.
    String imagePath = event.imagePath;

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
          // Navigate to details if needed
           Navigator.pushNamed(context, AppRoutes.eventDetailsRoute, arguments: event);
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
                color: isDark ? AppColors.darkBackgroundColor.withValues(alpha: 0.9) : AppColors.whiteColor,
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
                      title,
                      style: TextStyle(
                        color: isDark ? AppColors.whiteColor : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // MARK: FAVORITE LOGIC START
                   InkWell(
                     onTap: () {
                       // Toggle Favorite in Firestore
                       event.isFavorite = !event.isFavorite;
                       FirebaseUtils.updateEvent(event);
                     },
                     child: Icon(
                       event.isFavorite ? Icons.favorite : Icons.favorite_border,
                       color: AppColors.lightBlueColor,
                       size: 24,
                     ),
                   )
                  // MARK: FAVORITE LOGIC END
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
