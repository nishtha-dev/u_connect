import 'package:flutter/material.dart';
import 'package:u_connect/core/constants/constants.dart';

class AppTheme {
  AppTheme();

  ThemeData get themeData {
    return ThemeData(
        primaryColor: AppColors.blue,
        canvasColor: AppColors.white,
        scaffoldBackgroundColor: AppColors.white,
        splashColor: AppColors.transparent,
        progressIndicatorTheme:
            const ProgressIndicatorThemeData(color: AppColors.white),
        bottomSheetTheme:
            const BottomSheetThemeData(backgroundColor: AppColors.white));
  }
}
