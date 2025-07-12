import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/amplifyconfiguration.dart';
import 'package:weather_app/screens/Auth/login_screen.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized;
    await configureAmplify();
    runApp(const MyApp());
  } on AmplifyException catch (e) {
    runApp(Text('Error initializing Amplify: ${e.message}'));
  }
}

Future<void> configureAmplify() async {
  try {
    await Amplify.addPlugin(AmplifyAuthCognito());
    await Amplify.configure(amplifyconfig);
  } on AmplifyException catch (e) {
    safePrint('Error configuring Amplify: ${e.message}');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Authenticator(
      child: MaterialApp(
        title: 'Weather App',
        builder: Authenticator.builder(),
        home: const LoginScreen(),
      ),
    );
  }
}
