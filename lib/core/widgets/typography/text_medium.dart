import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:u_connect/core/constants/constants.dart';
import 'package:u_connect/core/theme/app_style_text.dart';

class TextMedium extends StatelessWidget {
  final String text;

  final Color? color;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  const TextMedium({
    required this.text,
    super.key,
    this.color,
    this.overflow,
    this.textAlign,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
              color: color ?? AppColors.black,
              fontSize: 20,
              fontWeight: fontWeight)
          .lineHeight(30.sp),
      overflow: overflow ?? TextOverflow.ellipsis,
      textAlign: textAlign ?? TextAlign.justify,
    );
  }
}
