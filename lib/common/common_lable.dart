import 'package:flutter/material.dart';

import 'color_constants.dart';

class CommonLable extends StatelessWidget {
  const CommonLable({
    super.key,
    required this.text,
    required this.isIconAvailable,
    this.icon,
    this.onPressed,
  });
  final String text;
  final bool isIconAvailable;
  final IconData? icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
            color: ColorConstants.primaryTextColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        isIconAvailable
            ? IconButton(
              onPressed: onPressed,
              icon: Icon(icon, color: ColorConstants.primaryBlackColor),
            )
            : const Text(''),
      ],
    );
  }
}
