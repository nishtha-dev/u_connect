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

import '../../controller/controller.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  String userEmail = "";
  @override
  void initState() {
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
                child: SvgPicture.asset(AssetImages.forgotPasswordImage),
              ),
              SizedBox(height: 50.h),
              const TextLargeBold(text: AppLabels.forgotPasswordText),
              SizedBox(height: 10.h),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: AppLabels.emailInputHint),
                      onChanged: (value) {
                        setState(() {
                          userEmail = value;
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
                    SizedBox(height: 30.h),
                  ],
                ),
              ),
              BlocConsumer<AuthBloc, AuthState>(
                listenWhen: (previous, current) =>
                    previous.authStatus != current.authStatus,
                listener: (context, state) {
                  if (state.authStatus.isResetPasswordSuccess) {
                    context.pushReplacementNamed(
                      RouteEnum.loginPage.toName,
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
                      if (_formKey.currentState!.validate()) {
                        context
                            .read<AuthBloc>()
                            .add(ResetUserPassword(userEmail));
                      }
                    },
                    label: const TextSmallBold(
                      text: AppLabels.forgotPasswordButtonText,
                      color: AppColors.white,
                    ),
                  );
                },
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
