import 'package:flutter/material.dart';
import 'package:weather_app/common/color_constants.dart';

class CommonBody extends StatelessWidget {
  const CommonBody({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorConstants.primaryOrageColor,
            ColorConstants.secondaryOrageColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(child: SingleChildScrollView(child: child)),
    );
  }
}
