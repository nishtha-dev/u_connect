import 'package:flutter/material.dart';
import 'package:u_connect/core/constants/constants.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    required this.onPressed,
    required this.label,
    super.key,
    this.disabled = false,
    this.isLoading = false,
  });

  final VoidCallback onPressed;
  final Widget label;
  final bool disabled;
  final bool isLoading;

  void _onPressed() {
    if (disabled) return;
    onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: disabled ? .5 : 1,
      child: TextButton(
        style: const ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          foregroundColor: MaterialStatePropertyAll(AppColors.white),
        ),
        onPressed: _onPressed,
        child: isLoading
            ? const SizedBox.square(
                dimension: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : label,
      ),
    );
  }
}
