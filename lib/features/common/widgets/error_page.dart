import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:u_connect/core/constants/constants.dart';
import 'package:u_connect/core/widgets/widget.dart';

class ErrorPage extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? btnLabel;

  const ErrorPage({
    this.onPressed,
    this.btnLabel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextMediumBold(
              text: AppLabels.oopsError,
              color: AppColors.black,
            ),
            SizedBox(
              height: 16.h,
            ),
            const TextSmall(
              text: AppLabels.errorTryToResolve,
              color: AppColors.grey,
            ),
            SizedBox(
              height: 42.h,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 20.h, left: 20.w, right: 20.w),
        child: AppSecondaryButton(
          onPressed: onPressed ?? () => Navigator.of(context).pop(),
          label: Text(
            btnLabel ?? 'CLOSE',
          ),
        ),
      ),
    );
  }
}
