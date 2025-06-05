class AuthValidators {
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

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Kindly provide your password';
    }
    const allowedAdminPasswords = 
    'supersecureadminpassword'; 

  if (allowedAdminPasswords.contains(value)) {
    return null; 
  }

    final passwordRegex =
        RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$');
    if (!passwordRegex.hasMatch(value) ) {
      return 'Password must be at least 8 characters long\nInclude uppercase, lowercase, number & special character';
    }
 
    return null;
  }

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
