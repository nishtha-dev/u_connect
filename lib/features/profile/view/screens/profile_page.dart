import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
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
  // final UserDataModel userData;

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
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return state.userData.when(
            initialOrLoading: FullScreenLoader.new,
            failed: (message) => const ErrorPage(),
            success: (userData) {
              final int followCount = userData.userFollowingList.length;
              final int connectionCount = followCount > 500 ? 500 : followCount;
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
                                // SizedBox(height: 2.h),
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
                          const _ProfileInfoRow(),
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

class _ProfileInfoRow extends StatelessWidget {
  const _ProfileInfoRow({Key? key}) : super(key: key);

  final List<ProfileInfoItem> _items = const [
    // ProfileInfoItem("Posts", 900),
    ProfileInfoItem("Followers", 120),
    ProfileInfoItem("Following", 200),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
          color: AppColors.secondaryColor.withOpacity(0.5),
          borderRadius: const BorderRadius.all(Radius.circular(6))),
      constraints: const BoxConstraints(maxWidth: 400),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _items
            .map((item) => Expanded(
                    child: Row(
                  children: [
                    if (_items.indexOf(item) != 0)
                      VerticalDivider(
                        color: AppColors.black.withOpacity(0.8),
                        indent: 7.h,
                        endIndent: 7.h,
                      ),
                    Expanded(child: ProfileAnalyticsCardItem(item: item)),
                  ],
                )))
            .toList(),
      ),
    );
  }
}

class ProfileAnalyticsCardItem extends StatelessWidget {
  const ProfileAnalyticsCardItem({super.key, required this.item});

  final ProfileInfoItem item;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            item.value.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        Text(
          item.title,
          style: Theme.of(context).textTheme.bodySmall,
        )
      ],
    );
  }
}

class ProfileInfoItem {
  final String title;
  final int value;
  const ProfileInfoItem(this.title, this.value);
}
