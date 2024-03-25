import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:u_connect/core/constants/constants.dart';
import 'package:u_connect/core/widgets/widget.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key, required this.description});
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextMediumBold(
                text: 'About',
                color: AppColors.black,
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          TextSmall(text: description)
        ],
      ),
    );
  }
}
