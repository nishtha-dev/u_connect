import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:u_connect/core/constants/constants.dart';
import 'package:u_connect/core/enums/dropdown_enums.dart';
import 'package:u_connect/core/theme/app_style_text.dart';

class DropDownFormField<T extends DropdownMenuEnum> extends StatelessWidget {
  const DropDownFormField({
    required this.itemsData,
    required this.onValueChanged,
    this.selectedValue,
    super.key,
    this.hintText = '',
    this.isEnabled = true,
    this.disableHintText = '',
  });
  final List<T> itemsData;
  final String hintText;
  final String disableHintText;
  final T? selectedValue;
  final void Function(T?) onValueChanged;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<T>(
      style: const TextStyle(
              color: AppColors.black, fontSize: 20, fontWeight: FontWeight.w400)
          .lineHeight(30.sp),
      value: selectedValue?.name == '' ? null : selectedValue,
      disabledHint: isEnabled
          ? null
          : DefaultTextStyle(
              style: const TextStyle(
                      color: AppColors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w400)
                  .lineHeight(30.sp),
              child: Text(disableHintText),
            ),
      hint: DefaultTextStyle(
        style: const TextStyle(
                color: AppColors.black,
                fontSize: 20,
                fontWeight: FontWeight.w400)
            .lineHeight(30.sp),
        child: Text(hintText),
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 5.h),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.primaryColor),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.primaryColor),
        ),
        filled: true,
        fillColor: AppColors.white,
        border: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.primaryColor),
        ),
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: AppColors.white,
        ),
        scrollbarTheme: ScrollbarThemeData(
          radius: const Radius.circular(40),
          thickness: MaterialStateProperty.all(6),
          thumbVisibility: MaterialStateProperty.all(true),
          trackVisibility: MaterialStateProperty.all(true),
        ),
      ),
      items: isEnabled
          ? [
              for (var item in itemsData)
                DropdownMenuItem(
                  value: item,
                  child: Text(
                    item.name,
                  ),
                ),
            ]
          : [],
      onChanged: (val) {
        onValueChanged(val);
      },
    );
  }
}
