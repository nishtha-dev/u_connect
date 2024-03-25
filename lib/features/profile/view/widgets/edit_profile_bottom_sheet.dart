import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:u_connect/core/enums/dropdown_enums.dart';
import 'package:u_connect/core/widgets/widget.dart';
import 'package:u_connect/features/auth/models/user_data_model.dart';
import 'package:u_connect/features/common/widgets/drop_down_text_field.dart';
import 'package:u_connect/features/profile/controller/bloc/profile_bloc.dart';

import '../../../../core/constants/constants.dart';
import '../../../common/widgets/widgets.dart';

String? validateData(String? value, String fieldName) {
  if (value == null || value.isEmpty) {
    return "Please enter $fieldName";
  }
  return null;
}

class EditProfileBottomSheet extends StatefulWidget {
  const EditProfileBottomSheet({super.key, required this.userData});
  final UserDataModel userData;

  @override
  State<EditProfileBottomSheet> createState() => _EditProfileBottomSheetState();
}

class _EditProfileBottomSheetState extends State<EditProfileBottomSheet> {
  late UserData updatedUserData;
  @override
  void initState() {
    super.initState();
    updatedUserData = UserData(userName: widget.userData.name);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BottomSheetTitleWidget(),
          Expanded(
            child: ListView(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        EditFormFieldLayout(
                          titleName: 'Name*',
                          child: CustomTextField(
                              hintText: AppLabels.nameInputHint,
                              onChanged: (value) {
                                setState(() {
                                  updatedUserData.userName = value.trim();
                                });
                              },
                              initialValue: widget.userData.name,
                              maxLine: 1,
                              validator: (val) {
                                return validateData(val, 'name');
                              }),
                        ),
                        EditFormFieldLayout(
                          titleName: 'Headline',
                          child: CustomTextField(
                            hintText: AppLabels.enterTextHint,
                            onChanged: (value) {
                              setState(() {
                                updatedUserData.headline = value.trim();
                              });
                            },
                            initialValue: widget.userData.description,
                          ),
                        ),
                        EditFormFieldLayout(
                            titleName: 'Pronoun',
                            child: DropDownFormField<PronounTypeEnum>(
                              itemsData: PronounTypeEnum.filteredList,
                              hintText: AppLabels.pleaseSelect,
                              onValueChanged: (value) {
                                setState(() {
                                  updatedUserData.proNoun = value;
                                });
                              },
                              selectedValue: widget.userData.proNoun ??
                                  PronounTypeEnum.none,
                            )),
                        if (updatedUserData.proNoun?.isCustom ??
                            (widget.userData.proNoun?.isCustom ?? false)) ...[
                          EditFormFieldLayout(
                            key: const ValueKey('custom pronouns'),
                            titleName: 'Enter custom pronouns',
                            child: CustomTextField(
                              initialValue: updatedUserData.customPronoun ??
                                  widget.userData.customPronoun,
                              onChanged: (value) {
                                setState(() {
                                  updatedUserData.customPronoun = value.trim();
                                });
                              },
                            ),
                          ),
                        ],
                        EditFormFieldLayout(
                          key: const ValueKey('About Section'),
                          titleName: 'About Section',
                          child: CustomTextField(
                            hintText: AppLabels.enterTextHint,
                            onChanged: (value) {
                              setState(() {
                                updatedUserData.bio = value.trim();
                              });
                            },
                            initialValue:
                                updatedUserData.bio ?? widget.userData.bio,
                            maxLine: 5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
          BlocConsumer<ProfileBloc, ProfileState>(
              listenWhen: (previous, current) =>
                  previous.isUserUpdateSuccessFully !=
                  current.isUserUpdateSuccessFully,
              listener: (context, state) {
                if (state.isUserUpdateSuccessFully.isSuccess) {
                  context.pop();
                }
              },
              builder: (context, state) {
                return Container(
                  color: AppColors.white.withOpacity(0.8),
                  child: Column(
                    children: [
                      Divider(
                        height: 10.h,
                        color: AppColors.grey,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      AppPrimaryButton(
                          isLoading: state.isUserUpdateSuccessFully.isLoading,
                          onPressed: () {
                            context
                                .read<ProfileBloc>()
                                .add(UpdateUserData(userData: updatedUserData));
                          },
                          label: const Text('Save')),
                      const _KeyboardHeight()
                    ],
                  ),
                );
              })
        ],
      ),
    );
  }
}

class EditFormFieldLayout extends StatelessWidget {
  const EditFormFieldLayout(
      {super.key, required this.titleName, required this.child});
  final String titleName;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextMediumBold(
          text: titleName,
          color: AppColors.black,
        ),
        SizedBox(
          height: 5.h,
        ),
        child,
        SizedBox(
          height: 15.h,
        ),
      ],
    );
  }
}

class BottomSheetTitleWidget extends StatelessWidget {
  const BottomSheetTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white.withOpacity(0.8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TextLargeBold(
                  text: 'Edit Intro',
                ),
                InkWell(
                  onTap: () {
                    context.pop();
                  },
                  child: const Icon(
                    Icons.close,
                    color: AppColors.black,
                    size: 24,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Divider(
            height: 5.h,
            color: AppColors.grey,
          ),
          SizedBox(
            height: 5.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: const TextExtraSmall(
              text: '* Indicates required',
              color: AppColors.grey,
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
        ],
      ),
    );
  }
}

class UserData {
  String userName;
  String? headline;
  PronounTypeEnum? proNoun;
  String? bio;
  String? customPronoun;

  UserData(
      {required this.userName,
      this.headline,
      this.proNoun,
      this.bio,
      this.customPronoun});
}

class _KeyboardHeight extends StatelessWidget {
  const _KeyboardHeight();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).viewInsets.bottom,
    );
  }
}
