import 'package:flutter/material.dart';
import 'package:u_connect/core/constants/app_colors.dart';

class FullScreenLoader extends StatelessWidget {
  final double? size;
  final bool bottomPadding;
  const FullScreenLoader({Key? key, this.size, this.bottomPadding = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            color: AppColors.secondaryColor,
          ),
          if (bottomPadding)
            SizedBox(height: MediaQuery.of(context).size.height * 0.1)
        ],
      ),
    );
  }
}
