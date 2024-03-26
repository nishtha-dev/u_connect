import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:u_connect/core/constants/constants.dart';
import 'package:u_connect/core/utils/utils.dart';
import 'package:u_connect/core/widgets/widget.dart';
import 'package:u_connect/features/auth/controller/controller.dart';
import 'package:u_connect/features/auth/models/user_data_model.dart';
import 'package:u_connect/features/profile/controller/bloc/profile_bloc.dart';
import 'package:u_connect/features/profile/view/widgets/capture_image_bottom_sheet.dart';
import 'package:u_connect/features/profile/view/widgets/edit_icon.dart';
import 'package:u_connect/features/profile/view/widgets/edit_profile_bottom_sheet.dart';

class ImageSection extends StatelessWidget {
  const ImageSection({Key? key, required this.userData, required this.bloc})
      : super(key: key);
  final UserDataModel userData;
  final ProfileBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return Stack(
        fit: StackFit.expand,
        children: [
          Container(
              margin: const EdgeInsets.only(bottom: 50),
              decoration: const BoxDecoration(),
              child: Image.asset(AssetImages.profileBanner, fit: BoxFit.cover)),
          Positioned(
            top: 40.h,
            right: 25.w,
            child: GestureDetector(
              onTap: () {
                context.read<AuthBloc>().add(LogoutEvent());
              },
              child: const Icon(
                Icons.logout,
                color: AppColors.white,
                size: 30,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: 150,
              height: 150,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: state.profileImageDownloadUrl is Loading
                          ? const ImageLoader()
                          : RenderProfileImage(
                              imageUrl: userData.avatar ??
                                  AssetImages.defaultProfileAvatar)),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          useSafeArea: true,
                          clipBehavior: Clip.hardEdge,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12))),
                          context: context,
                          builder: (BuildContext context) {
                            return BlocProvider.value(
                              value: bloc,
                              child: const CaptureProfileImage(),
                            );
                          },
                        );
                      },
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.white,
                        child: Container(
                          margin: const EdgeInsets.all(8.0),
                          decoration: const BoxDecoration(
                              color: AppColors.blue, shape: BoxShape.circle),
                          child: const Icon(
                            Icons.add,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 10.h,
              right: 15.w,
              child: EditIconToOpenBottomSheet(
                onTap: () {
                  showModalBottomSheet(
                    useSafeArea: true,
                    isScrollControlled: true,
                    clipBehavior: Clip.hardEdge,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12))),
                    context: context,
                    builder: (BuildContext context) {
                      return BlocProvider.value(
                        value: bloc,
                        child: EditProfileBottomSheet(userData: userData),
                      );
                    },
                  );
                },
              ))
        ],
      );
    });
  }
}

class RenderProfileImage extends StatelessWidget {
  const RenderProfileImage({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final String imageExtension = ImageUtils.getImageExtension(imageUrl);
    return imageExtension.contains("svg")
        ? SvgPicture.network(
            placeholderBuilder: (context) {
              return const ImageLoader();
            },
            imageUrl,
            fit: BoxFit.cover,
          )
        : Image.network(
            frameBuilder: (
              BuildContext context,
              Widget child,
              int? frame,
              bool wasSynchronouslyLoaded,
            ) {
              if (frame != null) {
                return child;
              }
              return const ImageLoader();
            },
            imageUrl,
            fit: BoxFit.cover,
          );
  }
}
