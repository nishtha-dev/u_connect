import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:u_connect/core/constants/constants.dart';

class AdditionalAccountInfo extends StatelessWidget {
  final String infoText;
  final String linkText;
  final Function onTapHandler;
  const AdditionalAccountInfo({
    Key? key,
    required this.infoText,
    required this.linkText,
    required this.onTapHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: const TextStyle(
            color: AppColors.secondaryColor,
            fontWeight: FontWeight.w700,
            fontSize: 16,
            height: 1.6),
        children: <TextSpan>[
          TextSpan(text: infoText),
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                onTapHandler();
              },
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w700,
              fontSize: 16,
              height: 1.6,
              decoration: TextDecoration.underline,
            ),
            text: linkText,
          ),
        ],
      ),
    );
  }
}
