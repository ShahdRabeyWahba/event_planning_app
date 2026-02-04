import 'package:email_validator/email_validator.dart';
import 'package:event_planning_app/Firebase_utils.dart';
import 'package:event_planning_app/widgets/custom_text_field.dart';
import 'package:event_planning_app/utils/dialog_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:event_planning_app/l10n/app_localizations.dart';
import 'package:event_planning_app/providers/app_theme_provider.dart';
import 'package:event_planning_app/utils/app_assets.dart';
import 'package:event_planning_app/utils/app_colors.dart';

class ForgetPasswordTab extends StatefulWidget {
  const ForgetPasswordTab({super.key});

  @override
  State<ForgetPasswordTab> createState() => _ForgetPasswordTabState();
}

class _ForgetPasswordTabState extends State<ForgetPasswordTab> {
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
        centerTitle: true,
        title: Image.asset(
          AppAssets.logoBg,
          height: 40,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.error, color: Colors.red),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: provider.isDarkMode()
                  ? AppColors.darkBgColor
                  : AppColors.whiteColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new,
                  color: provider.isDarkMode()
                      ? AppColors.whiteColor
                      : AppColors.darkBgColor),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                Image.asset(
                  provider.isDarkMode()
                      ? AppAssets.changeSetting
                      : AppAssets.changeSettingDark,
                  height: height * 0.40,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error, color: Colors.red, size: 50),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  hintText: AppLocalizations.of(context)!.enterEmail,
                  fillColor: provider.isDarkMode()
                      ? AppColors.inputsColor
                      : AppColors.whiteColor,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return AppLocalizations.of(context)!.emailEmpty;
                    }
                    if (!EmailValidator.validate(value.trim())) {
                      return AppLocalizations.of(context)!.invalidEmail;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    resetPassword();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkBgColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.resetPassword,
                    style: const TextStyle(
                      fontSize: 20,
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void resetPassword() async {
    if (_formKey.currentState?.validate() == true) {
      DialogUtils.showLoading(context, AppLocalizations.of(context)!.loading);
      try {
        await FirebaseUtils.resetPassword(emailController.text.trim());
        if (mounted) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context, 'Password reset email sent',
              posActionName: AppLocalizations.of(context)!.ok);
        }
      } on FirebaseAuthException catch (e) {
        if (mounted) {
          DialogUtils.hideLoading(context);
          String message = AppLocalizations.of(context)!.error;
          if (e.code == 'user-not-found') {
            message = AppLocalizations.of(context)!.userNotFound;
          } else if (e.code == 'invalid-email') {
            message = AppLocalizations.of(context)!.invalidEmail;
          } else if (e.code == 'network-request-failed') {
            message = AppLocalizations.of(context)!.networkError;
          }
          DialogUtils.showMessage(context, message,
              title: AppLocalizations.of(context)!.error);
        }
      } catch (e) {
        if (mounted) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context, e.toString(),
              title: AppLocalizations.of(context)!.error);
        }
      }
    }
  }
}
