import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:u_connect/core/constants/constants.dart';
import 'package:u_connect/core/theme/app_style_text.dart';

class TextExtraSmall extends StatelessWidget {
  final String text;

  final Color? color;
  final TextOverflow? overflow;
  final TextAlign? textAlign;

  const TextExtraSmall({
    required this.text,
    super.key,
    this.color,
    this.overflow,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? AppColors.black,
        fontSize: 12.sp,
      ).lineHeight(18.sp),
      overflow: overflow ?? TextOverflow.ellipsis,
      textAlign: textAlign ?? TextAlign.justify,
      maxLines: 2,
    );
  }
}
