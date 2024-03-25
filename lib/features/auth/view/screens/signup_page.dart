import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:svg_flutter/svg.dart';
import 'package:u_connect/core/constants/auth_status.dart';
import 'package:u_connect/core/constants/constants.dart';
import 'package:u_connect/core/route/route_utils.dart';
import 'package:u_connect/core/utils/utils.dart';
import 'package:u_connect/core/widgets/components/app_primary_button.dart';
import 'package:u_connect/core/widgets/typography/typography.dart';
import 'package:u_connect/features/auth/models/user_data_model.dart';
import 'package:u_connect/features/auth/view/widgets/additional_account_info.dart';
import 'package:u_connect/features/common/widgets/custom_text_field.dart';

import '../../controller/controller.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  SignUpUserData userData = SignUpUserData();
  bool checkValidation = true;
  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              SizedBox(height: 20.h),
              SizedBox(
                height: deviceSize.height * .3,
                child: SvgPicture.asset(AssetImages.signUpPageImage),
              ),
              SizedBox(height: 50.h),
              const TextLargeBold(
                text: AppLabels.signUpWelcomeText,
                maxLine: 2,
              ),
              SizedBox(height: 10.h),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      hintText: AppLabels.emailInputHint,
                      onChanged: (value) {
                        setState(() {
                          userData.email = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter email";
                        }
                        if (!Validation.isValidEmail(value)) {
                          return "Please enter a valid email";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.h),
                    CustomTextField(
                      hintText: AppLabels.nameInputHint,
                      onChanged: (value) {
                        context
                            .read<AuthBloc>()
                            .add(SetUserName(userName: value));
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your name";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.h),
                    CustomTextField(
                      isObscured: true,
                      hintText: AppLabels.passwordInputHint,
                      onChanged: (value) {
                        setState(() {
                          userData.passWord = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a password";
                        }
                        if (value.length < 8) {
                          return "Password must be at least 8 characters long";
                        }
                        if (!Validation.isAValidPassword(value)) {
                          return "Password should contain at least one letter and one number.";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30.h),
                  ],
                ),
              ),
              BlocConsumer<AuthBloc, AuthState>(
                listenWhen: (previous, current) =>
                    previous.authStatus != current.authStatus,
                listener: (context, state) {
                  if (state.authStatus.isSignUpSuccess) {
                    context.goNamed(
                      RouteEnum.homePage.toName,
                    );
                  }
                  if (state.authStatus.isFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: AppColors.primaryColor,
                        content: TextSmallBold(
                          text: state.authStatus.getErrorString,
                          color: AppColors.white,
                        ),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return AppPrimaryButton(
                    isLoading: state.authStatus.isLoading,
                    onPressed: () async {
                      final form = _formKey.currentState;
                      if (form!.validate()) {
                        context
                            .read<AuthBloc>()
                            .add(SignUpUser(userData: userData));
                      }
                    },
                    label: const TextSmallBold(
                      text: AppLabels.signUpText,
                      color: AppColors.white,
                    ),
                  );
                },
              ),
              SizedBox(height: 20.h),
              AdditionalAccountInfo(
                infoText: AppLabels.signUpInfoText,
                linkText: AppLabels.signUpLinkText,
                onTapHandler: () {
                  context.pushReplacementNamed(RouteEnum.loginPage.toName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
