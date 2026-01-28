import 'package:event_planning_app/l10n/app_localizations.dart';
import 'package:event_planning_app/providers/app_theme_provider.dart';
import 'package:event_planning_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeBottomSheet extends StatelessWidget {
  const ThemeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.04,
          vertical: height * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: height * 0.02,
        children: [
          InkWell(
            onTap: () {
              //todo change theme to dark
             themeProvider.changeTheme(ThemeMode.dark) ;
            },
            child: !themeProvider.isDarkMode() ?
            getSelectedItemWidget(context: context,
                theme: AppLocalizations.of(context)!.dark) :
            getUnSelectedItemWidget(context: context,
                theme: AppLocalizations.of(context)!.dark),
          ),
          InkWell(
              onTap: () {
                //todo change theme to light
                themeProvider.changeTheme(ThemeMode.light) ;
              },
            child: themeProvider.isDarkMode() ?
            getSelectedItemWidget(context: context,
                theme: AppLocalizations.of(context)!.light) :
            getUnSelectedItemWidget(context: context,
                theme: AppLocalizations.of(context)!.light),
    ),
  ],
    ),
    );
  }

  Widget getSelectedItemWidget({required BuildContext context,
    required String theme}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(theme, style: TextStyle(color: AppColors.lightBlueColor),),
        Icon(Icons.check, color: AppColors.lightBlueColor,),
      ],
    );
  }

  Widget getUnSelectedItemWidget({required BuildContext context,
    required String theme}) {
    return Text(theme);
  }
}
