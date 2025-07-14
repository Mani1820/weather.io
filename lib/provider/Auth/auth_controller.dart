import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_provider.dart';

class AuthController extends Notifier<void> {
  @override
  void build() {}

  Future<void> login() async {
    final ref = this.ref;

    ref.read(authErrorProvider.notifier).state = null;
    final email = ref.read(emailProvider);
    final password = ref.read(passwordProvider);
    ref.read(authLoadingProvider.notifier).state = true;

    try {
      final result = await Amplify.Auth.signIn(
        username: email,
        password: password,
      );
      if (result.isSignedIn) {
        ref.read(isAuthenticatedProvider.notifier).state = true;
        ref.read(userEmailProvider.notifier).state = email;
        ref.read(userNameProvider.notifier).state = email.split('@')[0];

        final AuthUser user = await Amplify.Auth.getCurrentUser();
        ref.read(userIdProvider.notifier).state = user.userId;
      }
    } on AmplifyException catch (e) {
      final errorMessage = e.message;
      ref.read(authErrorProvider.notifier).state = errorMessage;
    } finally {
      ref.read(authLoadingProvider.notifier).state = false;
    }
  }

  Future<void> logout() async {
    final ref = this.ref;

    ref.read(authLoadingProvider.notifier).state = true;

    try {
      await Amplify.Auth.signOut();
      ref.read(isAuthenticatedProvider.notifier).state = false;
      ref.read(authErrorProvider.notifier).state = null;
      ref.read(emailProvider.notifier).state = '';
      ref.read(passwordProvider.notifier).state = '';
      ref.read(userIdProvider.notifier).state = null;
      ref.read(userNameProvider.notifier).state = null;
      ref.read(userEmailProvider.notifier).state = null;
    } on AmplifyException catch (e) {
      final errorMessage = e.message;
      ref.read(authErrorProvider.notifier).state = errorMessage;
    } finally {
      ref.read(authLoadingProvider.notifier).state = false;
    }
  }

  Future<bool> initialCheck() async {
    safePrint('--- initialCheck: START (Calling fetchAuthSession) ---'); // New log
    final ref = this.ref;
    try {
      final result = await Amplify.Auth.fetchAuthSession(); // <--- This is where it's hanging
      safePrint('--- initialCheck: fetchAuthSession COMPLETED. Is signed in: ${result.isSignedIn} ---'); // New log
      if (result.isSignedIn) {
        safePrint('--- initialCheck: User IS signed in, fetching current user ---'); // New log
        final user = await Amplify.Auth.getCurrentUser();
        ref.read(userIdProvider.notifier).state = user.userId;
        ref.read(isAuthenticatedProvider.notifier).state = true;
        safePrint('--- initialCheck: User ID set: ${user.userId} ---'); // New log
      } else {
        safePrint('--- initialCheck: User NOT signed in ---'); // New log
        ref.read(isAuthenticatedProvider.notifier).state = false;
      }
      return result.isSignedIn;
    } on AuthException catch (e) {
      safePrint('--- initialCheck: AuthException: ${e.message} ---');
      ref.read(authErrorProvider.notifier).state = e.message;
      ref.read(isAuthenticatedProvider.notifier).state = false;
      debugPrint('----------------------------${e.message}');
      return false;
    } catch (e) {
      safePrint('--- initialCheck: UNEXPECTED ERROR: $e ---');
      ref.read(authErrorProvider.notifier).state = e.toString();
      ref.read(isAuthenticatedProvider.notifier).state = false;
      return false;
    }
  }
}

final authControllerProvider = NotifierProvider<AuthController, void>(
  () => AuthController(),
);

final authCheckProvider = FutureProvider<bool>((ref) async {
      final authController = ref.read(authControllerProvider.notifier);
      final isSignedIn = await authController.initialCheck();
      ref.read(isAuthenticatedProvider.notifier).state = isSignedIn;
      return isSignedIn;
    });
