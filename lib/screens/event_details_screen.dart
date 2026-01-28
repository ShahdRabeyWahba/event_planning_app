import 'package:event_planning_app/l10n/app_localizations.dart';
import 'package:event_planning_app/providers/app_theme_provider.dart';
import 'package:event_planning_app/utils/app_colors.dart';
import 'package:event_planning_app/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventDetailsScreen extends StatelessWidget {
  static const String routeName = 'event_details_screen';

  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var localizations = AppLocalizations.of(context)!;
    bool isDark = themeProvider.isDarkMode();

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackgroundColor : AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.darkBackgroundColor : AppColors.whiteColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? AppColors.lightBlueColor : AppColors.blackColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          localizations.eventDetails,
          style: TextStyle(
            color: isDark ? AppColors.lightBlueColor : AppColors.blackColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: AppColors.lightBlueColor),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.editEventRoute);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: AppColors.redColor),
            onPressed: () {
              // Handle delete
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Image
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage('assets/images/image_sport.png'), // Placeholder
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Event Title
            Text(
              "We're going to play football", // Placeholder title
              style: TextStyle(
                color: isDark ? AppColors.lightBlueColor : AppColors.lightBlueColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Date and Time Box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                 color: isDark ? AppColors.darkBgColor : AppColors.whiteColor,
                 borderRadius: BorderRadius.circular(16),
                 border: Border.all(color: AppColors.lightBlueColor),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.lightBlueColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                     child: const Icon(Icons.calendar_month, color: AppColors.lightBlueColor),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                         "21 January", // Placeholder
                         style: TextStyle(
                           color: isDark ? AppColors.whiteColor : AppColors.lightBlueColor,
                           fontWeight: FontWeight.bold,
                           fontSize: 16,
                         ),
                      ),
                      Text(
                        "12:12 PM", // Placeholder
                        style: TextStyle(
                          color: isDark ? AppColors.whiteColor : AppColors.blackColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Location Box (Optional based on design, design had map icon possibly?) 
            // The design shows Date/Time, so sticking to that.

            const SizedBox(height: 16),

            // Description Title
            Text(
              localizations.eventDescription,
              style: TextStyle(
                color: isDark ? AppColors.whiteColor : AppColors.blackColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            
            // Description Text
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ...", // Placeholder description
              style: TextStyle(
                color: isDark ? AppColors.whiteColor : AppColors.blackColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
