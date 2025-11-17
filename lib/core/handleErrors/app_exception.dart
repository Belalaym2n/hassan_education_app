/// الكلاس الأساسي لكل Exceptions في النظام
abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  const AppException({
    required this.message,
    this.code,
    this.originalError,
  });

  @override
  String toString() => '$runtimeType: $message';
}

/// استثناء Firebase Auth
class FirebaseAuthExceptionHandler extends AppException {
  const FirebaseAuthExceptionHandler({
    required super.message,
    super.code,
    super.originalError,
  });
}

/// استثناء Firestore
class FirestoreExceptionHandler extends AppException {
  const FirestoreExceptionHandler({
    required super.message,
    super.code,
    super.originalError,
  });
}

/// استثناء الشبكة
class NetworkException extends AppException {
  const NetworkException({
    required super.message,
    super.code,
    super.originalError,
  });
}
class CacheException extends AppException {
  const CacheException({
    required super.message,
    super.code,
    super.originalError,
  });

  @override
  String toString() => 'CacheException: $message';
}
/// استثناء غير معروف
class UnknownException extends AppException {
  const UnknownException({
    required super.message,
    super.code,
    super.originalError,
  });
}
