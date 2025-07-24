import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:weather_app/common/color_constants.dart';
import 'package:weather_app/common/common_body.dart';
import 'package:weather_app/common/common_button.dart';
import 'package:weather_app/common/common_lable.dart';
import 'package:weather_app/common/common_textfield.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/provider/Auth/auth_controller.dart';
import 'package:weather_app/provider/Auth/auth_provider.dart';
import 'package:weather_app/screens/Auth/register_screen.dart';
import 'package:weather_app/utils/validators.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bool isloading = ref.watch(authLoadingProvider);

    final authController = ref.read(authControllerProvider.notifier);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          CommonBody(
            child: Form(
              key: _formKey,
              child: _formContainer(size, authController),
            ),
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

  Widget _formContainer(size, authController) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: size.width,
      decoration: BoxDecoration(
        color: const Color.fromARGB(121, 255, 240, 225),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: _buildFormColumn(authController),
    );
  }

  Widget _buildFormColumn(authController) {
    final email = ref.watch(emailProvider);
    final password = ref.watch(passwordProvider);
    return Column(
      spacing: 10,
      children: [
        Text(
          Constants.welcomeBack,
          style: TextStyle(
            color: ColorConstants.primaryTextColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          Constants.logintoyouracc,
          style: TextStyle(
            color: ColorConstants.secondaryTextColor,
            fontSize: 16,
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
            ref.read(emailProvider.notifier).state = value;
          },
        ),
        CommonLable(text: Constants.password, isIconAvailable: false),
        CommonTextfield(
          hintText: Constants.passwordhint,
          controller: TextEditingController(text: password)
            ..selection = TextSelection(
              baseOffset: password.length,
              extentOffset: password.length,
            ),
          validator: passwordValidator,
          keyboardType: TextInputType.visiblePassword,
          onChanged: (value) {
            ref.read(passwordProvider.notifier).state = value;
          },
        ),
        _forgotPassword(),
        _loginButton(authController),
        const SizedBox(height: 10),

        const SizedBox(height: 10),
        _signUpLabel(),
      ],
    );
  }

  _openDialog(BuildContext context, authError) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorConstants.cardPrimaryBackground,
          title: Text('Error'),
          content: Text(authError ?? ''),
          actions: [
            TextButton(
              child: Text(
                'OK',
                style: TextStyle(
                  color: ColorConstants.orageTextColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _forgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: Text(
          Constants.forgotpassword,

          style: TextStyle(color: ColorConstants.orageTextColor),
        ),
      ),
    );
  }

  Widget _loginButton(authController) {
    final authError = ref.watch(authErrorProvider);
    return CommonButton(
      text: Constants.login,
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          authController.login();
          authError != null ? _openDialog(context, authError) : null;
        }
      },
    );
  }

  Widget _signUpLabel() {
    return Text.rich(
      TextSpan(
        text: Constants.dontHaveAccount,
        style: TextStyle(
          color: ColorConstants.secondaryTextColor,
          fontSize: 16,
        ),
        children: [
          WidgetSpan(
            child: GestureDetector(
              onTap: onTapSignup,
              child: Text(
                Constants.signUp,
                style: TextStyle(
                  color: ColorConstants.orageTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onTapSignup() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const RegisterScreen()),
      (route) => false,
    );
  }
}
