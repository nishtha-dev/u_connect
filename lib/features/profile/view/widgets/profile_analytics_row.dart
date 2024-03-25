import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:u_connect/features/profile/models/profile_analytics_item.model.dart';

import '../../../../core/constants/constants.dart';

class ProfileAnalyticsDataRow extends StatelessWidget {
  const ProfileAnalyticsDataRow({Key? key}) : super(key: key);

  final List<ProfileAnalyticsItemModel> _items = const [
    ProfileAnalyticsItemModel("Followers", 120),
    ProfileAnalyticsItemModel("Following", 200),
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

  final ProfileAnalyticsItemModel item;

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
