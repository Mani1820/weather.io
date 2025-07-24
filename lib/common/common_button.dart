import 'package:flutter/material.dart';
import 'package:weather_app/common/color_constants.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({super.key, required this.text, this.onPressed});
  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size.width * 0.8,
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xFFFFBA71),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: ColorConstants.primaryTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
