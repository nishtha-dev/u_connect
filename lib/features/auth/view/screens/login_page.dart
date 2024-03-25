import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:svg_flutter/svg.dart';
import 'package:u_connect/core/constants/auth_status.dart';
import 'package:u_connect/core/constants/constants.dart';
import 'package:u_connect/core/route/route_utils.dart';
import 'package:u_connect/core/utils/validation.dart';
import 'package:u_connect/core/widgets/components/app_primary_button.dart';
import 'package:u_connect/core/widgets/typography/typography.dart';
import 'package:u_connect/features/auth/models/user_data_model.dart';
import 'package:u_connect/features/auth/view/view.dart';
import 'package:u_connect/features/common/widgets/widgets.dart';

import '../../controller/controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  LoginUserData userData = LoginUserData();
  @override
  void initState() {
    userData.email = "test123@abc.com";
    userData.passWord = "Test1234";
    super.initState();
  }

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
              SizedBox(height: 10.h),
              SizedBox(
                height: deviceSize.height * .3,
                child: SvgPicture.asset(AssetImages.loginPageImage),
              ),
              SizedBox(height: 50.h),
              const TextLargeBold(
                text: AppLabels.loginWelcomeText,
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
                    CustomTextField(
                      hintText: AppLabels.passwordInputHint,
                      isObscured: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter password";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          userData.passWord = value;
                        });
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
                  if (state.authStatus.isLoginSuccess) {
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
                        context.read<AuthBloc>().add(
                              LoginUser(userData: userData),
                            );
                      }
                    },
                    label: const TextSmallBold(
                      text: AppLabels.loginText,
                      color: AppColors.white,
                    ),
                  );
                },
              ),
              SizedBox(height: 20.h),
              AdditionalAccountInfo(
                infoText: AppLabels.loginInfoText,
                linkText: AppLabels.loginLinkText,
                onTapHandler: () {
                  context.pushReplacementNamed(RouteEnum.signUpPage.toName);
                },
              ),
              SizedBox(
                height: 5.h,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    context.pushNamed(RouteEnum.forgotPasswordPage.toName);
                  },
                  child: const TextSmall(
                    text: AppLabels.forgotPasswordText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
