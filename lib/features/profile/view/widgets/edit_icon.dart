import 'package:flutter/material.dart';
import 'package:u_connect/core/constants/constants.dart';

class EditIconToOpenBottomSheet extends StatelessWidget {
  const EditIconToOpenBottomSheet({super.key, required this.onTap});
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: const Icon(
        Icons.edit_outlined,
        color: AppColors.black,
        size: 30,
      ),
    );
  }
}
