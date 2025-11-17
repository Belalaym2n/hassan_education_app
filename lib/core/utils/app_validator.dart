class Validators {
  /// التحقق إن النص مش فاضي
  static String? requiredField(String? value, {String message = 'مطلوب'}) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  /// التحقق إن القيمة URL صالح
  static String? validUrl(String? value, {String message = 'رابط غير صالح'}) {
    if (value == null || value.trim().isEmpty) {
      return 'مطلوب';
    }

    final trimmed = value.trim();
    final uri = Uri.tryParse(trimmed);

    if (uri == null || !(uri.isScheme("http") || uri.isScheme("https"))) {
      return message;
    }
    return null;
  }

  /// التحقق إن الرابط يوتيوب فقط
  static String? youtubeUrl(String? value,
      {String message = 'يجب إدخال رابط فيديو من يوتيوب'}) {

    final error = validUrl(value);
    if (error != null) return error;

    final v = value!.trim();
    if (!v.contains("youtube.com") && !v.contains("youtu.be")) {
      return message;
    }

    return null;
  }

  /// التحقق إن الكود لو موجود يبقى صحيح
  static String? optionalCode(String? value) {
    if (value == null || value.trim().isEmpty) return null; // اختياري

    if (value.length < 4) {
      return "الكود يجب أن يكون 4 أحرف على الأقل";
    }

    return null;
  }
}
