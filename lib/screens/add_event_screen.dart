import 'package:event_planning_app/l10n/app_localizations.dart';
import 'package:event_planning_app/providers/app_theme_provider.dart';
import 'package:event_planning_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddEventScreen extends StatefulWidget {
  static const String routeName = 'add_event_screen';

  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  int selectedCategoryIndex = 0;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String selectedImagePath = 'assets/images/Book Club.png';

  final List<String> galleryImages = [
    'assets/images/Book Club.png',
    'assets/images/Sport.png',
    'assets/images/Birthday.png',
    'assets/images/Meeting.png',
    'assets/images/Exhibition.png',
    'assets/images/Holiday.png', // Added missing according to categories
    'assets/images/Workshop.png',
    'assets/images/Eating.png'
  ];


  final List<String> categories = [
    "Book Club",
    "Sport",
    "Birthday",
    "Meeting",
    "Exhibition",
    "Holiday",
    "Workshop",
    "Eating"
  ];
  

  final List<IconData> categoryIcons = [
    Icons.menu_book,
    Icons.directions_bike,
    Icons.cake,
    Icons.meeting_room,
    Icons.museum,
    Icons.beach_access,
    Icons.handyman,
    Icons.restaurant
  ];

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var localizations = AppLocalizations.of(context)!;
    bool isDark = themeProvider.isDarkMode();

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackgroundColor : AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.darkBackgroundColor : AppColors.backgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkBackgroundColor : AppColors.whiteColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              iconSize: 20,
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.arrow_back_ios_new_sharp,
                color: isDark ? AppColors.whiteColor : AppColors.darkBgColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        title: Text(
          localizations.addEvent,
          style: TextStyle(
            color: isDark ? AppColors.lightBlueColor : AppColors.blackColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Image Placeholder
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(
                    isDark 
                        ? selectedImagePath.replaceAll('.png', ' dark.png') 
                        : selectedImagePath,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              // You'd switch this image based on selectedCategoryIndex
            ),
            const SizedBox(height: 16),
            
            // Category Tabs
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  bool isSelected = selectedCategoryIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategoryIndex = index;
                        selectedImagePath = galleryImages[index];
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? AppColors.lightBlueColor 
                            : (isDark ? Colors.transparent : Colors.transparent),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.lightBlueColor,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            categoryIcons[index],
                            color: isSelected 
                                ? AppColors.whiteColor 
                                : AppColors.lightBlueColor,
                            size: 20,    
                          ),
                          const SizedBox(width: 8),
                          Text(
                            categories[index], 
                            style: TextStyle(
                              color: isSelected 
                                  ? AppColors.whiteColor 
                                  : (isDark ? AppColors.whiteColor : AppColors.blackColor),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            
            const SizedBox(height: 24),
            
            // Date Picker
            _buildDateRow(context, localizations, isDark),
            const SizedBox(height: 16),

             // Time Picker
            _buildTimeRow(context, localizations, isDark),
            const SizedBox(height: 16),

            // Title Field
            Text(
              localizations.eventTitle,
              style: TextStyle(
                color: isDark ? AppColors.whiteColor : AppColors.blackColor,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.edit, color: isDark ? AppColors.whiteColor : AppColors.blackColor),
                hintText: localizations.eventTitle,
                hintStyle: TextStyle(color: isDark ? AppColors.minGrayColor : AppColors.grayColor),
                filled: true,
                fillColor: isDark ? AppColors.darkBackgroundColor : AppColors.whiteColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: AppColors.grayColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: AppColors.grayColor),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppColors.grayColor)
                ),
              ),
              style: TextStyle(color: isDark ? AppColors.whiteColor : AppColors.blackColor),
            ),
            const SizedBox(height: 16),

            // Description Field
            Text(
              localizations.eventDescription,
              style: TextStyle(
                color: isDark ? AppColors.whiteColor : AppColors.blackColor,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                hintText: localizations.eventDescription,
                hintStyle: TextStyle(color: isDark ? AppColors.minGrayColor : AppColors.grayColor),
                filled: true,
                fillColor: isDark ? AppColors.darkBackgroundColor : AppColors.whiteColor, 
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: AppColors.grayColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: AppColors.grayColor),
                ),
                 focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppColors.grayColor)
                ),
              ),
               style: TextStyle(color: isDark ? AppColors.whiteColor : AppColors.blackColor),
            ),
            const SizedBox(height: 16),

            const SizedBox(height: 16),
            
            // Add Eve..nt Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  // Add event logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkBgColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  localizations.addEvent,
                  style: const TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateRow(BuildContext context, AppLocalizations localizations, bool isDark) {
    return Row(
      children: [
        Icon(Icons.calendar_month, color: isDark ? AppColors.whiteColor : AppColors.blackColor),
        const SizedBox(width: 8),
        Text(
          localizations.eventDate,
          style: TextStyle(
            color: isDark ? AppColors.whiteColor : AppColors.blackColor, 
            fontSize: 16
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: () async {
            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
            if (picked != null) {
              setState(() {
                selectedDate = picked;
              });
            }
          },
          child: Text(
            selectedDate == null 
                ? localizations.chooseDate 
                : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
            style: const TextStyle(
              color: AppColors.lightBlueColor,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.lightBlueColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeRow(BuildContext context, AppLocalizations localizations, bool isDark) {
    return Row(
      children: [
        Icon(Icons.access_time, color: isDark ? AppColors.whiteColor : AppColors.blackColor),
        const SizedBox(width: 8),
        Text(
          localizations.eventTime,
          style: TextStyle(
            color: isDark ? AppColors.whiteColor : AppColors.blackColor, 
            fontSize: 16
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: () async {
            TimeOfDay? picked = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (picked != null) {
              setState(() {
                selectedTime = picked;
              });
            }
          },
          child: Text(
            selectedTime == null 
                ? localizations.chooseTime 
                : selectedTime!.format(context),
            style: const TextStyle(
              color: AppColors.lightBlueColor,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.lightBlueColor,
            ),
          ),
        ),
      ],
    );
  }
}
