import 'package:flutter/material.dart';
import 'package:weather_app/common/color_constants.dart';
import 'package:weather_app/constants/constants.dart';

class CommonTextfield extends StatelessWidget {
  const CommonTextfield({
    super.key,
    required this.hintText,
    required this.controller,
    this.keyboardType,
    this.validator,
    this.onChanged,
  });

  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      style: TextStyle(
        fontSize: 16,
        color: ColorConstants.primaryTextColor,
        fontFamily: Constants.appFont,
      ),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 16,
          color: ColorConstants.secondaryTextColor,
          fontFamily: Constants.appFont,
        ),
        filled: true,
        fillColor: const Color(0xFFFFF7EE),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: const Color(0xFFFFEBD9)),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: const Color(0xFFFFEBD9)),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: const Color(0xFFFFEBD9)),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
      ),
    );
  }
}
