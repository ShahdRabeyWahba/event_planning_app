import 'package:event_planning_app/l10n/app_localizations.dart';
import 'package:event_planning_app/tabes/favorite_tab.dart';
import 'package:event_planning_app/tabes/home_tab.dart';
import 'package:event_planning_app/tabes/profile_tab.dart';
import 'package:event_planning_app/utils/app_colors.dart';
import 'package:event_planning_app/utils/app_routes.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 2; // Default to Profile Tab as requested for design task

  List<Widget> tabs = [
    const HomeTab(),
    const FavoriteTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context)!;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: selectedIndex,
        selectedItemColor: AppColors.lightBlueColor,
        unselectedItemColor: Theme.of(context).brightness == Brightness.dark 
            ? AppColors.whiteColor 
            : AppColors.minGrayColor,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
            label: localizations.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite_border),
            activeIcon: const Icon(Icons.favorite),
            label: localizations.favorite,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            activeIcon: const Icon(Icons.person),
            label: localizations.profile,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addEventRoute);
        },
        mini: true,
        shape: const CircleBorder(),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? AppColors.whiteColor
            : AppColors.darkBgColor,
        child: Icon(
          Icons.add,
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.darkBgColor
              : AppColors.whiteColor,
        ),
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: tabs,
      ),
    );
  }
}
