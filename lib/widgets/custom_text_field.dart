import 'package:event_planning_app/providers/app_theme_provider.dart';
import 'package:event_planning_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final Color? fillColor;
  final AutovalidateMode? autovalidateMode;
  final bool autocorrect;
  final bool enableSuggestions;
  final TextInputAction? textInputAction;
  final TextStyle? style;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.fillColor,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.textInputAction,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      keyboardType: keyboardType,
      autovalidateMode: autovalidateMode,
      autocorrect: autocorrect,
      enableSuggestions: enableSuggestions,
      textInputAction: textInputAction,
      style: style ??
          TextStyle(
            color: themeProvider.isDarkMode()
                ? AppColors.minGrayColor
                : AppColors.blackColor,
          ),
      decoration: InputDecoration(
        filled: fillColor != null,
        fillColor: fillColor,
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.minGrayColor),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.grayColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.grayColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.lightBlueColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.redColor),
        ),
      ),
    );
  }
}
