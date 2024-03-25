import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:u_connect/core/constants/constants.dart';

class ImageLoader extends StatelessWidget {
  const ImageLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: 150,
        height: 150,
        decoration:
            const BoxDecoration(color: AppColors.white, shape: BoxShape.circle),
      ),
    );
  }
}
