import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:u_connect/core/constants/auth_status.dart';
import 'package:u_connect/core/constants/constants.dart';
import 'package:u_connect/core/route/route_utils.dart';
import 'package:u_connect/core/widgets/typography/typography.dart';
import 'package:u_connect/features/auth/controller/bloc/auth_bloc.dart';
import 'package:u_connect/features/common/widgets/error_page.dart';
import 'package:u_connect/features/common/widgets/loading_widget.dart';
import 'package:u_connect/features/profile/controller/bloc/profile_bloc.dart';
import 'package:u_connect/features/profile/controller/repository/profile_repository_impl.dart';
import 'package:u_connect/features/profile/view/widgets/about_section.dart';
import 'package:u_connect/features/profile/view/widgets/profile_analytics_row.dart';
import 'package:u_connect/features/profile/view/widgets/profile_image_section.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) =>
            ProfileBloc(profileRepository: ProfileRepositoryImpl())
              ..add(const GetUserData()),
        child: const ProfileView(),
      ),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.authStatus.isInitial) {
          context.goNamed(
            RouteEnum.landingPage.toName,
          );
        }
      },
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listenWhen: (previous, current) =>
            previous.galleryAccessStatus != current.galleryAccessStatus ||
            previous.cameraPermissionFailureCount !=
                current.cameraPermissionFailureCount ||
            previous.cameraPermissionStatus != current.cameraPermissionStatus,
        listener: (context, state) {
          if (state.cameraPermissionFailureCount > 2) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: AppColors.primaryColor,
                content: TextSmallBold(
                  text: AppLabels.cameraDeniedCountExceeded,
                  color: AppColors.white,
                ),
              ),
            );
          } else if (state.cameraPermissionStatus == PermissionStatus.denied) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: AppColors.primaryColor,
                content: TextSmallBold(
                  text: AppLabels.cameraPermissionDenied,
                  color: AppColors.white,
                ),
              ),
            );
          } else if (state.galleryAccessStatus == PermissionStatus.denied) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: AppColors.primaryColor,
                content: TextSmallBold(
                  text: AppLabels.galleryPermissionDenied,
                  color: AppColors.white,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return state.userData.when(
            initialOrLoading: FullScreenLoader.new,
            failed: (message) => const ErrorPage(),
            success: (userData) {
              return Column(
                children: [
                  Expanded(
                      flex: 3,
                      child: ImageSection(
                          userData: userData,
                          bloc: context.read<ProfileBloc>())),
                  Expanded(
                    flex: 5,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.w, vertical: 15.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextLargeBold(
                                  text: userData.name,
                                  color: AppColors.black,
                                ),
                                TextMedium(
                                  text: (userData.selectedPronounName
                                              ?.isNotEmpty ??
                                          false)
                                      ? '(${userData.selectedPronounName})'
                                      : '',
                                  color: AppColors.grey,
                                ),
                                SizedBox(height: 10.h),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.w),
                                  child: TextSmall(
                                    color: AppColors.black,
                                    text: userData.description ?? '',
                                    maxLines: 5,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(height: 16.h),
                              ],
                            ),
                          ),
                          const ProfileAnalyticsDataRow(),
                          SizedBox(
                            height: 20.h,
                          ),
                          AboutSection(
                            description: userData.bio ?? '',
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}




