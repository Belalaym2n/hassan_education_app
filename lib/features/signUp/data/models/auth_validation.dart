class AuthValidator {
  static bool isValidEmail(String email) {
    final regex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.com$");
    return regex.hasMatch(email);
  }

  static String? validateEmail(String? value) {
    bool isValidGmail = isValidEmail(value ?? "");

    if (value == null || value.trim().isEmpty) {
      return 'البريد الإلكتروني مطلوب';
    }
    if (isValidGmail == false) {
      return 'صيغة البريد الإلكتروني غير صحيحة';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.length < 6) {
      return 'يجب أن تكون كلمة المرور 6 أحرف على الأقل';
    }
    return null;
  }

  static String? validateField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'هذا الحقل لا يجب أن يكون فارغًا';
    }
    return null;
  }

  static bool isValidPhone(String phone) {
    final regex = RegExp(r'^(?:\+?\d{1,3})?\d{10,15}$');
    return regex.hasMatch(phone);
  }

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'رقم الهاتف مطلوب';
    }

    if (!isValidPhone(value.trim())) {
      return 'رقم الهاتف غير صحيح';
    }

    return null;
  }
}
