import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/common/color_constants.dart';
import 'package:weather_app/provider/Auth/auth_provider.dart';

// import '../../provider/Errors/amplify_errors.dart';

class InitialCheckingErrorScreen extends ConsumerWidget {
  const InitialCheckingErrorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final errorMessage = ref.watch(authErrorProvider);
    return Scaffold(
      backgroundColor: ColorConstants.secondaryOrageColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Spacer(),
              CircleAvatar(
                radius: 50,
                backgroundColor: ColorConstants.cardPrimaryBackground,
                child: InkWell(
                  onTap: () {
                    Phoenix.rebirth(context);
                  },
                  child: Icon(
                    Icons.restart_alt,
                    size: 50,
                    color: ColorConstants.primaryTextColor,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                textAlign: TextAlign.center,
                errorMessage ??
                    'This is a backend error. Please restart the app',
                style: TextStyle(
                  color: ColorConstants.primaryTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
