import 'package:event_planning_app/utils/app_colors.dart';
import 'package:event_planning_app/utils/app_routes.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  static const String routName = 'intro_screen';
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int currentIndex = 0;
  final PageController _pageController = PageController();

  final List<Map<String, String>> pages = [
    {
      "image": "assets/images/hot-trending(1).png",
      "title": "Find Events That Inspire You",
      "description": "Dive into a world of events crafted to fit your unique interests."
          " Whether you're into live music, art workshops, professional networking, "
          "or simply discovering new experiences, we have something for everyone. "
          "Our curated recommendations will help you explore,"
          " connect, and make the most of every opportunity around you."
    },
    {
      "image": "assets/images/being-creative (2).png",
      "title": "Effortless Event Planning",
      "description": "Take the hassle out of organizing events with our all-in-one planning tools."
          " From setting up invites and managing RSVPs to scheduling reminders and coordinating details,"
          " we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests."
    },
    {
      "image": "assets/images/being-creative (3).png",
      "title": "Connect with Friends & Share Moments",
      "description": "Make every event memorable by sharing the experience with others."
          " Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together."
          " Capture and share the excitement with your network,"
          " so you can relive the highlights and cherish the memories."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/images/evently-app.png'),
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
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Align(
                  child:Image.asset(
                  pages[index]['image']!,
                  height: MediaQuery.of(context).size.height * 0.40,
                  fit: BoxFit.contain,
                ),
                ),
                const SizedBox(height: 24),
                Text(
                  pages[index]['title']!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  pages[index]['description']!,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16.0),
        color: AppColors.whiteColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             IconButton(
                 onPressed: (){
                   if (currentIndex > 0) {
                     _pageController.previousPage(
                         duration: const Duration(milliseconds: 300),
                         curve: Curves.easeInOut);
                   }
                 },
                 icon: Container(
                     padding: const EdgeInsets.all(10),
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(25),
                         border: Border.all(color: AppColors.primaryColor)
                     ),
                     child: const Icon(Icons.arrow_back, color: AppColors.primaryColor,))),
            Row(
              children: List.generate(
                pages.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: currentIndex == index ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: currentIndex == index
                        ? AppColors.primaryColor
                        : AppColors.blackColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            IconButton(
                onPressed: (){
                  if (currentIndex < pages.length - 1) {
                    _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                  } else {
                    Navigator.pushReplacementNamed(
                        context, AppRoutes.homescreenRoute);
                  }
                },
                icon: Container(
                  padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: AppColors.primaryColor)
                    ),
                    child: const Icon(Icons.arrow_forward, color: AppColors.primaryColor,))),
          ],
        ),
      ),
    );
  }
}
