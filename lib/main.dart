import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:weather_app/screens/Errors/amplify_error_screen.dart';
import 'package:weather_app/screens/Errors/initial_checking_error_screen.dart';
import 'package:weather_app/utils/amplifyconfiguration.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/screens/Auth/login_screen.dart';

import 'common/color_constants.dart';
import 'provider/Auth/auth_controller.dart';
import 'provider/Auth/auth_provider.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await configureAmplify();
    runApp(Phoenix(child: ProviderScope(child: const MyApp())));
  } on AmplifyException catch (e) {
    runApp(ProviderScope(child: AmplifyErrorScreen(error: e.message)));
  }
}

Future<void> configureAmplify() async {
  try {
    await Amplify.addPlugin(AmplifyAuthCognito());

    await Amplify.configure(amplifyconfig);
  } on AmplifyException catch (e) {
    debugPrint('Error configuring Amplify: ${e.message}');
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    bool isAuthenticated = ref.watch(isAuthenticatedProvider);
    final authChecking = ref.watch(authCheckProvider);
    return MaterialApp(
      title: Constants.appName,
      debugShowCheckedModeBanner: false,
      home: authChecking.when(
        data: (_) {
          return isAuthenticated
              ? Scaffold(
                body: Center(child: const SizedBox(child: Text('Signed In'))),
              )
              : const LoginScreen();
        },
        error: (error, stack) {
          return InitialCheckingErrorScreen();
        },
        loading:
            () => Scaffold(
              backgroundColor: ColorConstants.secondaryOrageColor,
              body: Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ),
      ),
    );
  }
}
