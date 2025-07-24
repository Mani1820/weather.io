import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:weather_app/common/common_body.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/common/common_button.dart';
import 'package:weather_app/common/common_lable.dart';
import 'package:weather_app/common/common_textfield.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/utils/validators.dart';

import '../../common/color_constants.dart';
import '../../provider/Auth/auth_provider.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final isloading = ref.watch(authLoadingProvider);
    return Scaffold(
      body: Stack(
        children: [
          CommonBody(
            child: Form(key: _formKey, child: _buildFormContainer(size)),
          ),
          isloading
              ? Container(
                color: const Color.fromARGB(17, 255, 255, 255),
                child: Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: ColorConstants.secondaryOrageColor,
                    size: 100,
                  ),
                ),
              )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _buildFormContainer(Size size) {
    return ClipRRect(
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            width: size.width,
            decoration: BoxDecoration(
              color: ColorConstants.cardPrimaryBackground,
              border: Border.all(color: const Color(0xFFFFEBD9)),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: _buildFormColumn(),
          ),
        ],
      ),
    );
  }

  Widget _buildFormColumn() {
    final email = ref.watch(registerEmailProvider);
    final password = ref.watch(registerPasswordProvider);
    final number = ref.watch(registerNumberProvider);
    final confirmPassword = ref.watch(registerConfirmPasswordProvider);
    return Column(
      spacing: 10,
      children: [
        Text(
          Constants.createAccount,
          style: TextStyle(
            color: ColorConstants.primaryTextColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        CommonLable(text: Constants.email, isIconAvailable: false),
        CommonTextfield(
          hintText: Constants.emailhint,
          controller: TextEditingController(text: email)
            ..selection = TextSelection(
              baseOffset: email.length,
              extentOffset: email.length,
            ),
          validator: emailValidator,
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            ref.read(registerEmailProvider.notifier).state = value;
          },
        ),
        CommonLable(text: Constants.phoneNumber, isIconAvailable: false),
        CommonTextfield(
          hintText: Constants.phoneNumberHint,
          controller: TextEditingController(text: number),
          validator: phoneNumberValidator,
          keyboardType: TextInputType.phone,
          onChanged:
              (value) =>
                  ref.read(registerNumberProvider.notifier).state = value,
        ),
        CommonLable(text: Constants.password, isIconAvailable: false),
        CommonTextfield(
          hintText: Constants.passwordhint,
          controller: TextEditingController(text: password),
          validator: passwordValidator,
          keyboardType: TextInputType.visiblePassword,
          onChanged: (value) {
            ref.read(registerPasswordProvider.notifier).state = value;
          },
        ),
        CommonLable(text: Constants.confirmPassword, isIconAvailable: false),
        CommonTextfield(
          hintText: Constants.confirmPasswordHint,
          controller: TextEditingController(text: confirmPassword),
          keyboardType: TextInputType.visiblePassword,
          validator: (value) => confirmPasswordValidator(password, value),
        ),
        SizedBox(height: 10),
        CommonButton(text: Constants.signUp, onPressed: () {}),
      ],
    );
  }
}
