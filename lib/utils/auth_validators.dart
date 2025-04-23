class AuthValidators {
  /// Name must be at least 2 characters and contain only letters and spaces
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Kindly provide your name';
    }
    final nameRegex = RegExp(r"^[a-zA-Z\s]{2,}$");
    if (!nameRegex.hasMatch(value.trim())) {
      return 'Enter a valid name (letters and spaces only)';
    }
    return null;
  }

  /// Email format validation
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Kindly provide your email';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }
    return null;
  }

  /// Password must be at least 8 characters, include a number, uppercase, lowercase, and special character
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Kindly provide your password';
    }
    final passwordRegex =
        RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$');
    if (!passwordRegex.hasMatch(value)) {
      return 'Password must be at least 8 characters long\nInclude uppercase, lowercase, number & special character';
    }
    return null;
  }

  /// Confirm password must match password
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Kindly confirm your password';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }
}
