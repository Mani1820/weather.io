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

String? confirmPasswordValidator(String? password, String? confirmPassword) {
  if (confirmPassword == null || confirmPassword.isEmpty) {
    return 'Confirm password is required';
  }
  if (password != confirmPassword) {
    return 'Passwords do not match';
  }
  return null;
}

String? phoneNumberValidator(String? phoneNumber) {
  if (phoneNumber == null || phoneNumber.isEmpty) {
    return 'Phone number is required';
  }
  if (phoneNumber.length != 10) {
    return 'Phone number must be 10 digits';
  }
  return null;
}
