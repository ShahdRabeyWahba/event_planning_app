import 'package:email_validator/email_validator.dart';
import 'package:event_planning_app/Firebase_utils.dart';
import 'package:event_planning_app/l10n/app_localizations.dart';
import 'package:event_planning_app/providers/app_theme_provider.dart';
import 'package:event_planning_app/providers/user_provider.dart';
import 'package:event_planning_app/utils/app_assets.dart';
import 'package:event_planning_app/utils/app_colors.dart';
import 'package:event_planning_app/utils/app_routes.dart';
import 'package:event_planning_app/widgets/custom_text_field.dart';
import 'package:event_planning_app/utils/dialog_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final _formKey = GlobalKey<FormState>();
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
          child: Form(
            key: _formKey,
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
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  enableSuggestions: false,
                  textInputAction: TextInputAction.next,
                  hintText: AppLocalizations.of(context)!.enterEmail,
                  prefixIcon: const Icon(Icons.email_outlined,
                      color: AppColors.minGrayColor),
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
                SizedBox(height: height * 0.02),
                CustomTextField(
                  controller: passwordController,
                  textInputAction: TextInputAction.done,
                  autocorrect: false,
                  enableSuggestions: false,
                  hintText: AppLocalizations.of(context)!.enterPassword,
                  obscureText: isObscure,
                  prefixIcon: const Icon(Icons.lock_outline,
                      color: AppColors.minGrayColor),
                  fillColor: provider.isDarkMode()
                      ? AppColors.inputsColor
                      : AppColors.whiteColor,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return AppLocalizations.of(context)!.passwordEmpty;
                    }
                    return null;
                  },
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                    icon: Icon(
                      isObscure
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.minGrayColor,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, AppRoutes.forgetPasswordRoute);
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
                    login();
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
                      style: const TextStyle(color: AppColors.darkGrayColor),
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
                      child: Text(AppLocalizations.of(context)!.or,
                          style: TextStyle(
                              color: provider.isDarkMode()
                                  ? AppColors.lightBlueColor
                                  : AppColors.darkBgColor)),
                    ),
                    const Expanded(child: Divider(color: AppColors.whiteColor)),
                  ],
                ),
                SizedBox(height: height * 0.02),
                ElevatedButton(
                  onPressed: () {
                    loginWithGoogle();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: provider.isDarkMode()
                        ? AppColors.darkBackgroundColor
                        : AppColors.whiteColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(
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
                      const Icon(Icons.g_mobiledata,
                          size: 30, color: AppColors.lightBlueColor),
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
      ),
    );
  }

  void login() async {
    if (_formKey.currentState?.validate() == true) {
      DialogUtils.showLoading(context, AppLocalizations.of(context)!.loading);
      try {
        var userCredential = await FirebaseUtils.loginWithEmailAndPassword(
          emailController.text.trim(),
          passwordController.text,
        );
        var user = await FirebaseUtils.readUserFromFirestore(userCredential.user?.uid ?? "");
        if (mounted) {
          var userProvider = Provider.of<UserProvider>(context, listen: false);
          userProvider.updateUser(user);
          DialogUtils.hideLoading(context);
          DialogUtils.showSuccessDialog(
            context,
            AppLocalizations.of(context)!.loginSuccess,
          );
          Future.delayed(const Duration(seconds: 2), () {
            if (mounted) {
              Navigator.pushReplacementNamed(context, AppRoutes.homescreenRoute);
            }
          });
        }
      } on FirebaseAuthException catch (e) {
        if (mounted) {
          DialogUtils.hideLoading(context);
          String message = AppLocalizations.of(context)!.error;
          if (e.code == 'user-not-found' || e.code == 'wrong-password' || e.code == 'invalid-credential') {
            message = AppLocalizations.of(context)!.invalidCredential;
          } else if (e.code == 'invalid-email') {
            message = AppLocalizations.of(context)!.invalidEmail;
          } else if (e.code == 'network-request-failed') {
            message = AppLocalizations.of(context)!.networkError;
          } else if (e.code == 'operation-not-allowed') {
            message = AppLocalizations.of(context)!.authDisabled;
          } else {
            message = "${e.message} (${e.code})";
          }
          DialogUtils.showErrorDialog(context, message);
        }
      } catch (e) {
        if (mounted) {
          DialogUtils.hideLoading(context);
          DialogUtils.showErrorDialog(context, e.toString());
        }
      }
    }
  }

  void loginWithGoogle() async {
    DialogUtils.showLoading(context, AppLocalizations.of(context)!.loading);
    try {
      final credential = await FirebaseUtils.signInWithGoogle();
      if (mounted) {
        DialogUtils.hideLoading(context);
        if (credential != null) {
          DialogUtils.showMessage(
            context,
            AppLocalizations.of(context)!.loginSuccess,
            posActionName: AppLocalizations.of(context)!.ok,
            posAction: () {
              Navigator.pushReplacementNamed(
                  context, AppRoutes.homescreenRoute);
            },
          );
        }
      }
    } catch (e) {
      if (mounted) {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context, 'Google Sign-In Failed',
            title: AppLocalizations.of(context)!.error);
      }
    }
  }
}
