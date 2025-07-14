import 'package:flutter_riverpod/flutter_riverpod.dart';

final emailProvider = StateProvider<String>((ref) {
  return '';
});
final passwordProvider = StateProvider<String>((ref) {
  return '';
});

final isAuthenticatedProvider = StateProvider<bool>((ref) {
  return false;
});

final authLoadingProvider = StateProvider<bool>((ref) {
  return false;
});
final authErrorProvider = StateProvider<String?>((ref) {
  return null;
});
final userIdProvider = StateProvider<String?>((ref) {
  return null;
});
final userNameProvider = StateProvider<String?>((ref) {
  return null;
});
final userEmailProvider = StateProvider<String?>((ref) {
  return null;
});
