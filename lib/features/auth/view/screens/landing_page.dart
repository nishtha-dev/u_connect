import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:svg_flutter/svg.dart';
import 'package:u_connect/core/route/route_utils.dart';
import 'package:u_connect/core/widgets/components/app_primary_button.dart';
import 'package:u_connect/core/widgets/components/app_secondary_button.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/typography/typography.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10.h),
            SizedBox(
              height: 60.h,
            ),
            Container(
              height: deviceSize.height * .35,
              clipBehavior: Clip.hardEdge,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: SvgPicture.asset(
                AssetImages.landingPageImage,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            const TextLargeBold(
              text: AppLabels.landingPageHeading,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 80.h,
            ),
            const Spacer(),
            AppPrimaryButton(
                onPressed: () {
                  context.pushNamed(RouteEnum.loginPage.toName);
                },
                label: const TextSmallBold(
                  color: AppColors.white,
                  text: AppLabels.loginText,
                )),
            SizedBox(
              height: 20.h,
            ),
            AppSecondaryButton(
                onPressed: () {
                  context.pushNamed(RouteEnum.signUpPage.toName);
                },
                label: const TextSmallBold(
                  color: AppColors.black,
                  text: AppLabels.signUpWelcomeText,
                )),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }
}
