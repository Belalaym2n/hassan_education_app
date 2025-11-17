/// قاعدة أساسية لكل أنواع الأخطاء في النظام
abstract class Failure {
  final String message;
  final String? code;
  final dynamic originalError;

  const Failure({
    required this.message,
    this.code,
    this.originalError,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Failure && other.message == message && other.code == code;
  }

  @override
  int get hashCode => message.hashCode ^ (code?.hashCode ?? 0);

  @override
  String toString() => '$runtimeType: $message';
}

/// 🔐 فشل في المصادقة (Firebase Auth)
class FirebaseAuthFailure extends Failure {
  const FirebaseAuthFailure({
    super.message = 'فشل في عملية تسجيل الدخول أو إنشاء الحساب',
    super.code = 'AUTH_ERROR',
    super.originalError,
  });

  @override
  String toString() => 'FirebaseAuthFailure: $message';
}

/// 🗄️ فشل في قاعدة البيانات (Firestore)
class FirestoreFailure extends Failure {
  const FirestoreFailure({
    super.message = 'حدث خطأ أثناء التعامل مع قاعدة البيانات',
    super.code = 'FIRESTORE_ERROR',
    super.originalError,
  });

  @override
  String toString() => 'FirestoreFailure: $message';
}

/// 🌐 فشل في الاتصال بالشبكة
class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'تحقق من اتصالك بالإنترنت',
    super.code = 'NETWORK_ERROR',
    super.originalError,
  });

  @override
  String toString() => 'NetworkFailure: $message';
}

/// ⏳ انتهاء مهلة الاتصال
class TimeoutFailure extends Failure {
  const TimeoutFailure({
    super.message = 'انتهت مهلة الاتصال، حاول مرة أخرى',
    super.code = 'TIMEOUT_ERROR',
    super.originalError,
  });

  @override
  String toString() => 'TimeoutFailure: $message';
}

/// ⚠️ خطأ غير معروف
class UnknownFailure extends Failure {
  const UnknownFailure({
    super.message = 'حدث خطأ غير معروف',
    super.code = 'UNKNOWN_ERROR',
    super.originalError,
  });

  @override
  String toString() => 'UnknownFailure: $message';
}

/// 🔑 فشل في الصلاحيات
class PermissionFailure extends Failure {
  const PermissionFailure({
    super.message = 'ليس لديك صلاحية لتنفيذ هذا الإجراء',
    super.code = 'PERMISSION_DENIED',
    super.originalError,
  });

  @override
  String toString() => 'PermissionFailure: $message';
}

/// 📱 فشل في الربط بالخدمة (Cloud Function أو أي خدمة أخرى)
class ServiceFailure extends Failure {
  const ServiceFailure({
    super.message = 'حدث خطأ في الخدمة، حاول مرة أخرى لاحقاً',
    super.code = 'SERVICE_ERROR',
    super.originalError,
  });

  @override
  String toString() => 'ServiceFailure: $message';
}

/// 🧠 امتدادات لتسهيل التعامل مع الأخطاء
extension FailureExtensions on Failure {
  /// هل الخطأ ناتج عن الشبكة؟
  bool get isNetworkError =>
      this is NetworkFailure || this is TimeoutFailure;

  /// هل الخطأ من Firebase Auth؟
  bool get isAuthError => this is FirebaseAuthFailure;

  /// هل الخطأ من Firestore؟
  bool get isFirestoreError => this is FirestoreFailure;

  /// هل الخطأ في الصلاحيات؟
  bool get isPermissionError => this is PermissionFailure;

  /// رسالة ودّية للمستخدم
  String get userMessage {
    if (isNetworkError) {
      return 'تحقق من اتصالك بالإنترنت.';
    } else if (isAuthError) {
      return 'حدث خطأ أثناء تسجيل الدخول، حاول مرة أخرى.';
    } else if (isFirestoreError) {
      return 'حدث خطأ أثناء تحميل البيانات.';
    } else if (isPermissionError) {
      return 'ليس لديك صلاحية كافية لتنفيذ هذا الإجراء.';
    } else {
      return message;
    }
  }
}
