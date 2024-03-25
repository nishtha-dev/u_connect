import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:u_connect/core/constants/app_colors.dart';
import 'package:u_connect/core/constants/app_labels.dart';
import 'package:u_connect/core/widgets/widget.dart';
import 'package:u_connect/features/profile/controller/bloc/profile_bloc.dart';

class CaptureProfileImage extends StatelessWidget {
  const CaptureProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextMediumBold(
            text: AppLabels.addProfilePhoto,
            color: AppColors.black,
          ),
          SizedBox(
            height: 20.h,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              context.read<ProfileBloc>().add(const CaptureImage());
            },
            child: Row(
              children: [
                const Icon(Icons.photo_camera, color: AppColors.black),
                SizedBox(
                  width: 10.w,
                ),
                const TextSmall(
                  text: AppLabels.takePhoto,
                  color: AppColors.black,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              context.read<ProfileBloc>().add(const SelectImage());
            },
            child: Row(
              children: [
                const Icon(Icons.photo_library_outlined,
                    color: AppColors.black),
                SizedBox(
                  width: 10.w,
                ),
                const TextSmall(
                  text: AppLabels.uploadFromPhotos,
                  color: AppColors.black,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
