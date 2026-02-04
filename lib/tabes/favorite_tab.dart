import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planning_app/Firebase_utils.dart';
import 'package:event_planning_app/models/event.dart';
import 'package:event_planning_app/l10n/app_localizations.dart';
import 'package:event_planning_app/providers/app_theme_provider.dart';
import 'package:event_planning_app/utils/app_colors.dart';
import 'package:event_planning_app/utils/app_routes.dart';
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
          events = events.where((element) => element.isFavorite == true).toList();
          if (events.isEmpty) {
             return Center(child: Text("No favorites yet"));
          }
          
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: events.length,
            itemBuilder: (context, index) {
              return _buildEventCard(context, events[index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildEventCard(BuildContext context, Event event) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    bool isDark = themeProvider.isDarkMode();
    
    // Extract data
    // Extract data
    String date = event.date;
    String desc = event.description;
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
                      event.title,
                      style: TextStyle(
                        color: isDark ? AppColors.whiteColor : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // MARK: FAVORITE TOGGLE START
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
                  // MARK: FAVORITE TOGGLE END
                ],
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }
}
