import 'package:event_planning_app/l10n/app_localizations.dart';
import 'package:event_planning_app/providers/app_language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

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
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.04,
          vertical: height * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: height * 0.02,
        children: [
          InkWell(
            onTap: () {
              //todo change language to english
              languageProvider.changeLanguage('en');
            },
            child: languageProvider.appLanguage == 'en' ?
            getSelectedItemWidget(context: context,
                language: AppLocalizations.of(context)!.english) :
            getUnSelectedItemWidget(context: context,
                language: AppLocalizations.of(context)!.english),
          ),
          InkWell(
              onTap: () {
                //todo change language to arabic
                languageProvider.changeLanguage('ar');
              },
              child: languageProvider.appLanguage == 'ar' ?
          getSelectedItemWidget(context: context,
              language: AppLocalizations.of(context)!.arabic) :
          getUnSelectedItemWidget(context: context,
              language: AppLocalizations.of(context)!.arabic),
    ),
  ],
    ),
    );
  }

  Widget getSelectedItemWidget({required BuildContext context,
    required String language}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(language),
        Icon(Icons.check),
      ],
    );
  }

  Widget getUnSelectedItemWidget({required BuildContext context,
    required String language}) {
    return Text(language);
  }
}
