import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:u_connect/core/constants/constants.dart';

class BottomTabBarView extends StatefulWidget {
  const BottomTabBarView(
      {super.key, required this.onTap, required this.selectedIndex});
  final Function(int currentIndex) onTap;
  final int selectedIndex;
  @override
  State<BottomTabBarView> createState() => _BottomTabBarViewState();
}

class _BottomTabBarViewState extends State<BottomTabBarView> {
  List<BottomNavigationBarItem> _buildItems() {
    return <BottomNavigationBarItem>[
      for (int i = 0; i < AppConstants.bottomTabs.length; i++)
        BottomNavigationBarItem(
            icon: SizedBox.square(
              dimension: 30.sp,
              child: AppConstants.bottomTabs[i].icon,
            ),
            label: AppConstants.bottomTabs[i].label),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 15.0,
      iconSize: 30,
      items: _buildItems(),
      currentIndex: widget.selectedIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.primaryColor,
      selectedItemColor: AppColors.secondaryColor,
      unselectedItemColor: AppColors.darkGrey.withOpacity(0.7),
      onTap: (int currentIndex) {
        if (currentIndex == 3) {
          widget.onTap(currentIndex);
        }
      },
    );
  }
}
