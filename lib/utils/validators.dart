String? emailValidator(String? email) {
  if (email == null || email.isEmpty) {
    return 'Email is required';
  }
  if (!email.contains('@')) {
    return 'Please enter a valid email';
  }
  return null;
}

String? passwordValidator(String? password) {
  if (password == null || password.isEmpty) {
    return 'Password is required';
  }
  if (password.length != 6) {
    return 'Password must be at least 6 characters';
  }
  return null;
}