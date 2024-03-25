import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:u_connect/core/constants/constants.dart';

class AppSecondaryButton extends StatelessWidget {
  const AppSecondaryButton({
    required this.onPressed,
    required this.label,
    this.disabled = false,
    this.minWidth,
    this.isLoading = false,
    super.key,
  });

  final VoidCallback onPressed;
  final Widget label;
  final bool disabled;
  final double? minWidth;
  final bool isLoading;

  void _onTap() {
    if (disabled || isLoading) return;
    onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 44.h,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.r),
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      minWidth: minWidth ?? ScreenUtil().screenWidth - 32.w,
      color: disabled ? AppColors.grey : AppColors.secondaryColor,
      textTheme: ButtonTextTheme.primary,
      onPressed: _onTap,
      child: DefaultTextStyle(
        style: const TextStyle(
          color: AppColors.black,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        child: isLoading
            ? const SizedBox.square(
                dimension: 20,
                child: CircularProgressIndicator(
                  color: AppColors.black,
                ),
              )
            : Opacity(
                opacity: disabled ? .5 : 1,
                child: label,
              ),
      ),
    );
  }
}
