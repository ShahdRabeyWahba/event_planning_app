import 'package:event_planning_app/l10n/app_localizations.dart';
import 'package:event_planning_app/providers/app_theme_provider.dart';
import 'package:event_planning_app/utils/app_assets.dart';
import 'package:event_planning_app/utils/app_colors.dart';
import 'package:event_planning_app/utils/app_routes.dart';
import 'package:event_planning_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterTab extends StatefulWidget {
  const RegisterTab({super.key});

  @override
  State<RegisterTab> createState() => _RegisterTabState();
}

class _RegisterTabState extends State<RegisterTab> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  bool isPasswordObscure = true;
  bool isRePasswordObscure = true;

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
                AppLocalizations.of(context)!.createAccount,
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
                controller: nameController,
                hintText: AppLocalizations.of(context)!.enterName,
                prefixIcon: const Icon(Icons.person, color: AppColors.darkGrayColor),
                fillColor: provider.isDarkMode()
                    ? AppColors.inputsColor
                    : AppColors.whiteColor,
              ),
              SizedBox(height: height * 0.02),
              CustomTextField(
                controller: emailController,
                hintText: AppLocalizations.of(context)!.enterEmail,
                prefixIcon: const Icon(Icons.email_outlined, color: AppColors.darkGrayColor),
                fillColor: provider.isDarkMode()
                    ? AppColors.inputsColor
                    : AppColors.whiteColor,
              ),
              SizedBox(height: height * 0.02),
              CustomTextField(
                controller: passwordController,
                hintText: AppLocalizations.of(context)!.enterPassword,
                obscureText: isPasswordObscure,
                prefixIcon: const Icon(Icons.lock_outline, color: AppColors.darkGrayColor),
                    fillColor: provider.isDarkMode()
                    ? AppColors.inputsColor
                    : AppColors.whiteColor,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isPasswordObscure = !isPasswordObscure;
                    });
                  },
                  icon: Icon(
                    isPasswordObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: AppColors.darkGrayColor,
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              CustomTextField(
                controller: rePasswordController,
                hintText: AppLocalizations.of(context)!.confirmPassword,
                obscureText: isRePasswordObscure,
                prefixIcon: const Icon(Icons.lock_outline, color: AppColors.darkGrayColor),
                fillColor: provider.isDarkMode()
                    ? AppColors.inputsColor
                    : AppColors.whiteColor,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isRePasswordObscure = !isRePasswordObscure;
                    });
                  },
                  icon: Icon(
                    isRePasswordObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: AppColors.darkGrayColor,
                  ),
                ),
              ),
              SizedBox(height: height * 0.03),
              ElevatedButton(
                onPressed: () {
                  // Register Logic
                  Navigator.pushNamed(context, AppRoutes.homescreenRoute);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkBgColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  AppLocalizations.of(context)!.signup,
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
                    AppLocalizations.of(context)!.alreadyHaveAccount,
                    style: TextStyle(color: provider.isDarkMode() ? AppColors.whiteColor : AppColors.darkGrayColor),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.loginRoute);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.login,
                      style: TextStyle(
                        color: provider.isDarkMode() ? AppColors.lightBlueColor : AppColors.darkBgColor,
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
                    child: Text(AppLocalizations.of(context)!.or, style: const TextStyle(color: AppColors.darkBgColor)),
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
                       color: provider.isDarkMode()
                           ? AppColors.lightBlueColor
                           : AppColors.darkBgColor),
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
                        color: provider.isDarkMode()
                            ? AppColors.whiteColor
                            : AppColors.darkBgColor), // Placeholder for Google Icon
                    SizedBox(width: 10),
                     Text(
                      AppLocalizations.of(context)!.loginWithGoogle,
                      style: TextStyle(
                        fontSize: 16,
                        color: provider.isDarkMode()
                            ? AppColors.whiteColor
                            : AppColors.darkBgColor,
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
