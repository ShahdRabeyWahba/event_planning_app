import 'package:event_planning_app/l10n/app_localizations.dart';
import 'package:event_planning_app/providers/app_theme_provider.dart';
import 'package:event_planning_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditEventScreen extends StatefulWidget {
  static const String routeName = 'edit_event_screen';

  const EditEventScreen({super.key});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  int selectedCategoryIndex = 0; // Should be initialized with event data
  DateTime? selectedDate = DateTime.now(); // Should be initialized with event data
  TimeOfDay? selectedTime = TimeOfDay.now(); // Should be initialized with event data

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
  
  // Controllers for text fields, should be initialized with event data
  final TextEditingController _titleController = TextEditingController(text: "Reading book club");
  final TextEditingController _descController = TextEditingController(text: "Lorem ipsum dolor sit amet...");

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
            }),
        title: Text(
          localizations.editEvent,
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
                image: const DecorationImage(
                   image: AssetImage('assets/images/image_sport.png'), // Should match category
                   fit: BoxFit.cover,
                ),
              ),
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
                          color: isSelected ? AppColors.lightBlueColor : AppColors.lightBlueColor,
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
                                  : AppColors.lightBlueColor,
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
            const SizedBox(height: 24),

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
              controller: _titleController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.edit, color: AppColors.grayColor),
                hintStyle: const TextStyle(color: AppColors.grayColor),
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
              controller: _descController,
              maxLines: 4,
              decoration: InputDecoration(
                hintStyle: const TextStyle(color: AppColors.grayColor),
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

            // Date Picker
            _buildDateRow(context, localizations, isDark),
            
            const SizedBox(height: 16),

             // Time Picker
            _buildTimeRow(context, localizations, isDark),
            
            const SizedBox(height: 32),
            
            // Update Event Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  // Update logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.lightBlueColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  localizations.updateEvent,
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
          style: TextStyle(color: isDark ? AppColors.whiteColor : AppColors.blackColor, fontSize: 16),
        ),
        const Spacer(),
        TextButton(
          onPressed: () async {
            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: selectedDate ?? DateTime.now(),
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
            style: const TextStyle(color: AppColors.lightBlueColor),
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
          style: TextStyle(color: isDark ? AppColors.whiteColor : AppColors.blackColor, fontSize: 16),
        ),
        const Spacer(),
        TextButton(
          onPressed: () async {
            TimeOfDay? picked = await showTimePicker(
              context: context,
              initialTime: selectedTime ?? TimeOfDay.now(),
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
            style: const TextStyle(color: AppColors.lightBlueColor),
          ),
        ),
      ],
    );
  }
}
