import 'package:flutter_riverpod/flutter_riverpod.dart';

final initialCheckErrorProvider = StateProvider<String?>((ref) {
  return '';
});