
import 'package:event_planning_app/l10n/app_localizations.dart';
import 'package:event_planning_app/providers/app_theme_provider.dart';
import 'package:event_planning_app/utils/app_colors.dart';
import 'package:event_planning_app/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IntroScreen extends StatefulWidget {
  static const String routName = 'intro_screen';
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int currentIndex = 0;
  final PageController _pageController = PageController();

  List<Map<String, String>> getLocalizedPages(BuildContext context) {
    return [
      {
        "image": "assets/images/hot-trending.png",
        "title": "introTitle1",
        "description": "introDesc1"
      },
      {
        "image": "assets/images/being-creative (1).png",
        "title": "introTitle2",
        "description": "introDesc2"
      },
      {
        "image": "assets/images/being-creative (2).png",
        "title": "introTitle3",
        "description": "introDesc3"
      },
    ];
  }

  String _getLocalizedTitle(AppLocalizations localizations, int index) {
    switch (index) {
      case 0:
        return localizations.introTitle1;
      case 1:
        return localizations.introTitle2;
      case 2:
        return localizations.introTitle3;
      default:
        return '';
    }
  }

  String _getLocalizedDescription(AppLocalizations localizations, int index) {
    switch (index) {
      case 0:
        return localizations.introDesc1;
      case 1:
        return localizations.introDesc2;
      case 2:
        return localizations.introDesc3;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    final localizations = AppLocalizations.of(context)!;
    final pages = getLocalizedPages(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/images/appbar logo.png'),
        leading: IconButton(
          onPressed: () {
            if (currentIndex > 0) {
              _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.bounceIn);
            }
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: themeProvider.appTheme == ThemeMode.dark
                ? AppColors.darkBlueColor
                : AppColors.darkBgColor,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(
                  context, AppRoutes.loginRoute);
            },
            child: Text(
              localizations.skip,
              style: TextStyle(
                color: themeProvider.appTheme == ThemeMode.dark
                    ? AppColors.darkBlueColor
                    : AppColors.darkBgColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        itemCount: pages.length,
        itemBuilder: (context, index) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 24),
                          Align(
                            child: Image.asset(
                              pages[index]['image']!,
                              height: MediaQuery.of(context).size.height * 0.40,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              pages.length,
                              (idx) => Container(
                                margin: const EdgeInsets.symmetric(horizontal: 4),
                                width: currentIndex == idx ? 24 : 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: currentIndex == idx
                                      ? AppColors.lightBlueColor
                                      : (themeProvider.appTheme == ThemeMode.dark
                                          ? AppColors.whiteColor
                                          : AppColors.blackColor),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            _getLocalizedTitle(localizations, index),
                            textAlign: TextAlign.start,
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
                            _getLocalizedDescription(localizations, index),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 16,
                              color: themeProvider.appTheme == ThemeMode.dark
                                  ? AppColors.darkGrayColor
                                  : AppColors.darkGrayColor,
                            ),
                          ),
                          const Spacer(),
                          const SizedBox(height: 24),
                          InkWell(
                            onTap: () {
                              if (currentIndex < pages.length - 1) {
                                _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut);
                              } else {
                                Navigator.pushReplacementNamed(
                                    context, AppRoutes.loginRoute);
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 32, left: 40, right: 40),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: themeProvider.appTheme == ThemeMode.dark
                                    ? AppColors.darkBlueColor
                                    : AppColors.darkBgColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Text(
                                  currentIndex < pages.length - 1
                                      ? localizations.next
                                      : localizations.getStarted,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
