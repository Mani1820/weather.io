import 'package:flutter/material.dart';
import 'package:weather_app/common/color_constants.dart';

class AmplifyErrorScreen extends StatelessWidget {
  const AmplifyErrorScreen({super.key, required this.error});
  final String error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.secondaryOrageColor,
      body: Column(
        children: [
          const Spacer(),
          CircleAvatar(
            radius: 100,
            backgroundColor: ColorConstants.cardPrimaryBackground,
            child: Icon(
              Icons.error,
              size: 100,
              color: ColorConstants.primaryTextColor,
            ),
          ),
          Text(
            'This is a backend error. $error. Please restart the app',style: TextStyle(
              color: ColorConstants.primaryTextColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),),
          const Spacer(),
        ],
      ),
    );
  }
}