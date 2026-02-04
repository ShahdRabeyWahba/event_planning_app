import 'package:email_validator/email_validator.dart';
import 'package:event_planning_app/Firebase_utils.dart';
import 'package:event_planning_app/l10n/app_localizations.dart';
import 'package:event_planning_app/models/my_user.dart';
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
  final _formKey = GlobalKey<FormState>();
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
          child: Form(
            key: _formKey,
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
                  textInputAction: TextInputAction.next,
                  hintText: AppLocalizations.of(context)!.enterName,
                  prefixIcon:
                      const Icon(Icons.person, color: AppColors.darkGrayColor),
                  fillColor: provider.isDarkMode()
                      ? AppColors.inputsColor
                      : AppColors.whiteColor,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return AppLocalizations.of(context)!.nameEmpty;
                    }
                    return null;
                  },
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
                      color: AppColors.darkGrayColor),
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
                  textInputAction: TextInputAction.next,
                  autocorrect: false,
                  enableSuggestions: false,
                  hintText: AppLocalizations.of(context)!.enterPassword,
                  obscureText: isPasswordObscure,
                  prefixIcon: const Icon(Icons.lock_outline,
                      color: AppColors.darkGrayColor),
                  fillColor: provider.isDarkMode()
                      ? AppColors.inputsColor
                      : AppColors.whiteColor,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return AppLocalizations.of(context)!.passwordEmpty;
                    }
                    if (value.length < 6) {
                      return AppLocalizations.of(context)!.passwordShort;
                    }
                    return null;
                  },
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isPasswordObscure = !isPasswordObscure;
                      });
                    },
                    icon: Icon(
                      isPasswordObscure
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.darkGrayColor,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.02),
                CustomTextField(
                  controller: rePasswordController,
                  textInputAction: TextInputAction.done,
                  autocorrect: false,
                  enableSuggestions: false,
                  hintText: AppLocalizations.of(context)!.confirmPassword,
                  obscureText: isRePasswordObscure,
                  prefixIcon: const Icon(Icons.lock_outline,
                      color: AppColors.darkGrayColor),
                  fillColor: provider.isDarkMode()
                      ? AppColors.inputsColor
                      : AppColors.whiteColor,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.confirmPasswordEmpty;
                    }
                    if (value != passwordController.text) {
                      return AppLocalizations.of(context)!.passwordMismatch;
                    }
                    return null;
                  },
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isRePasswordObscure = !isRePasswordObscure;
                      });
                    },
                    icon: Icon(
                      isRePasswordObscure
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.darkGrayColor,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.03),
                ElevatedButton(
                  onPressed: () {
                    register();
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
                      style: TextStyle(
                          color: provider.isDarkMode()
                              ? AppColors.whiteColor
                              : AppColors.darkGrayColor),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.loginRoute);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.login,
                        style: TextStyle(
                          color: provider.isDarkMode()
                              ? AppColors.lightBlueColor
                              : AppColors.darkBgColor,
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
                    registerWithGoogle();
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
                      const SizedBox(width: 10),
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
      ),
    );
  }

  void register() async {
    if (_formKey.currentState?.validate() == true) {
      DialogUtils.showLoading(context, AppLocalizations.of(context)!.loading);
      String email = emailController.text.trim();
      String password = passwordController.text;
      
      try {
        UserCredential credential;
        try {
          credential = await FirebaseUtils.registerWithEmailAndPassword(email, password);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'email-already-in-use') {
            // If already exists, try logging in with the same password
            credential = await FirebaseUtils.loginWithEmailAndPassword(email, password);
          } else {
            rethrow;
          }
        }

        MyUser user = MyUser(
          id: credential.user?.uid,
          name: nameController.text.trim(),
          email: email,
        );

        try {
          await FirebaseUtils.addUserToFirestore(user);
        } catch (e) {
          throw Exception("Auth OK, Database FAIL: $e");
        }
        
        if (mounted) {
          var userProvider = Provider.of<UserProvider>(context, listen: false);
          userProvider.updateUser(user);
          DialogUtils.hideLoading(context);
          DialogUtils.showSuccessDialog(
            context,
            AppLocalizations.of(context)!.accountCreated,
          );
          // Auto-navigate after a small delay
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
          if (e.code == 'weak-password') {
            message = AppLocalizations.of(context)!.weakPassword;
          } else if (e.code == 'email-already-in-use') {
            message = AppLocalizations.of(context)!.emailAlreadyInUse;
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

  void registerWithGoogle() async {
    DialogUtils.showLoading(context, AppLocalizations.of(context)!.loading);
    try {
      final credential = await FirebaseUtils.signInWithGoogle();
      if (mounted) {
        DialogUtils.hideLoading(context);
        if (credential != null) {
          MyUser user = MyUser(
            id: credential.user?.uid,
            name: credential.user?.displayName ?? nameController.text.trim(),
            email: credential.user?.email ?? emailController.text.trim(),
          );
          await FirebaseUtils.addUserToFirestore(user);
          if (mounted) {
            var userProvider = Provider.of<UserProvider>(context, listen: false);
            userProvider.updateUser(user);
          }
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
