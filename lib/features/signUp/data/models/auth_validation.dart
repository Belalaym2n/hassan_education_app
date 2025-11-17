class AuthValidator {
  static bool isValidEmail(String email) {
    final regex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.com$");
    return regex.hasMatch(email);
  }

  static String? validateEmail(String? value) {
    bool isValidGmail = isValidEmail(value ?? "");

    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    if (isValidGmail == false) {
      return 'Invalid email format';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? validateField(String? value) {
    if (value == null ||  value.trim().isEmpty) {
      return 'this field must be at not empty';
    }
    return null;
  }
  static bool isValidPhone(String phone) {
    final regex = RegExp(r'^(?:\+?\d{1,3})?\d{10,15}$');
    return regex.hasMatch(phone);
  }

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }

    if (!isValidPhone(value.trim())) {
      return 'Invalid phone number';
    }

    return null;

}
}
