import 'package:event_planning_app/l10n/app_localizations.dart';
import 'package:event_planning_app/providers/app_theme_provider.dart';
import 'package:event_planning_app/utils/app_assets.dart';
import 'package:event_planning_app/utils/app_colors.dart';
import 'package:event_planning_app/utils/app_routes.dart';
import 'package:event_planning_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginTab extends StatefulWidget {
  const LoginTab({super.key});

  @override
  State<LoginTab> createState() => _LoginTabState();
}

class _LoginTabState extends State<LoginTab> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var provider = Provider.of<AppThemeProvider>(context);

    return Scaffold(
      backgroundColor: provider.isDarkMode()
          ? AppColors.darkBackgroundColor
          : AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: provider.isDarkMode()
            ? AppColors.darkBackgroundColor
            : AppColors.backgroundColor,
        automaticallyImplyLeading: false,
        title: Image.asset(AppAssets.logoBg),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                AppLocalizations.of(context)!.loginToAccount,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: provider.isDarkMode()
                      ? AppColors.whiteColor
                      : AppColors.darkBgColor,
                ),
              ),
              SizedBox(height: height * 0.02),
              CustomTextField(
                controller: emailController,
                hintText: AppLocalizations.of(context)!.enterEmail,
                prefixIcon: const Icon(Icons.email_outlined, color: AppColors.minGrayColor),
                  fillColor: provider.isDarkMode()
                      ? AppColors.inputsColor
                      : AppColors.whiteColor),
              SizedBox(height: height * 0.02),
              CustomTextField(
                controller: passwordController,
                hintText: AppLocalizations.of(context)!.enterPassword,
                obscureText: isObscure,
                 prefixIcon: const Icon(Icons.lock_outline, color: AppColors.minGrayColor),
                  fillColor: provider.isDarkMode()
                      ? AppColors.inputsColor
                      : AppColors.whiteColor,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  icon: Icon(
                    isObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: AppColors.minGrayColor,
                  ),
                  color: AppColors.whiteColor,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.forgetPasswordRoute);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.forgetPassword,
                    style: TextStyle(
                      color: provider.isDarkMode()
                          ? AppColors.lightBlueColor
                          : AppColors.darkBgColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
               SizedBox(height: height * 0.02),
              ElevatedButton(
                onPressed: () {
                   // Login Logic
                   Navigator.pushNamed(context, AppRoutes.homescreenRoute);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: provider.isDarkMode()
                      ? AppColors.lightBlueColor
                      : AppColors.darkBgColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  AppLocalizations.of(context)!.login,
                  style: const TextStyle(
                    fontSize: 20,
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.dontHaveAccount,
                    style: TextStyle(
                        color: provider.isDarkMode()
                            ? AppColors.darkGrayColor
                            : AppColors.darkGrayColor),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.registerRoute);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.signup,
                      style: TextStyle(
                        color: provider.isDarkMode()
                            ? AppColors.lightBlueColor
                            : AppColors.inputsColor,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
               SizedBox(height: height * 0.02),
              Row(
                children: [
                   const Expanded(child: Divider(color: AppColors.whiteColor)),
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 10),
                     child: Text(AppLocalizations.of(context)!.or, style: TextStyle(color: provider.isDarkMode() ? AppColors.lightBlueColor : AppColors.darkBgColor)),
                   ),
                  const Expanded(child: Divider(color: AppColors.whiteColor)),
                ],
              ),
              SizedBox(height: height * 0.02),
              ElevatedButton(
                onPressed: () {
                  // Google Logic
                },
                style: ElevatedButton.styleFrom(
                   backgroundColor: provider.isDarkMode()
                       ? AppColors.darkBackgroundColor
                       : AppColors.whiteColor,
                   padding: const EdgeInsets.symmetric(vertical: 16),
                   side: BorderSide(
                       color: AppColors.lightBlueColor,
                       width: 1.5,
                   ),
                   shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                   elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.g_mobiledata,
                        size: 30,
                        color: AppColors.lightBlueColor), // Placeholder for Google Icon
                    const SizedBox(width: 10),
                     Text(
                      AppLocalizations.of(context)!.loginWithGoogle,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.lightBlueColor,
                         fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
