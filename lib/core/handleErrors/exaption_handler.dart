import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'app_exception.dart';
import 'failures.dart';
import 'error_model.dart';

/// ✅ ExceptionHandler
/// هذا الكلاس مسؤول عن:
///  - استقبال جميع الأخطاء (من Firebase أو أي نوع آخر)
///  - تحويلها إلى AppException مناسبة
///  - ثم تحويل AppException إلى Failure لتتعامل معها في الـ UI
class ExceptionHandler {
   static AppException handle(dynamic error) {
    // 👇 أخطاء Firebase Auth
    if (error is FirebaseAuthException) {
      return FirebaseAuthExceptionHandler(
        message: _getFirebaseAuthErrorMessage(error),
        code: error.code,
        originalError: error,
      );
    }

    // 👇 أخطاء Firestore
    else if (error is FirebaseException &&
        error.plugin == 'cloud_firestore') {
      return FirestoreExceptionHandler(
        message: error.message ?? 'حدث خطأ أثناء التعامل مع قاعدة البيانات',
        code: error.code,
        originalError: error,
      );
    }

    // 👇 أخطاء الشبكة
    else if (error.toString().contains('network') ||
        error.toString().contains('socket') ||
        error.toString().contains('timeout')) {
      return NetworkException(
        message: 'تحقق من اتصالك بالإنترنت',
        code: 'NETWORK_ERROR',
        originalError: error,
      );
    }

    // 👇 أي خطأ آخر
    else {
      return UnknownException(
        message: error.toString(),
        code: 'UNKNOWN',
        originalError: error,
      );
    }
  }

  /// 🧠 تحويل AppException إلى Failure
  static Failure exceptionToFailure(AppException exception) {
    if (exception is FirebaseAuthExceptionHandler) {
      return FirebaseAuthFailure(
        message: exception.message,
        code: exception.code,
        originalError: exception.originalError,
      );
    } else if (exception is FirestoreExceptionHandler) {
      return FirestoreFailure(
        message: exception.message,
        code: exception.code,
        originalError: exception.originalError,
      );
    } else if (exception is NetworkException) {
      return NetworkFailure(
        message: exception.message,
        code: exception.code,
        originalError: exception.originalError,
      );
    } else {
      return UnknownFailure(
        message: exception.message,
        code: exception.code,
        originalError: exception.originalError,
      );
    }
  }

  /// 🔎 دالة خاصة لترجمة أكواد Firebase Auth إلى رسائل مفهومة
  static String _getFirebaseAuthErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'البريد الإلكتروني غير صالح';
      case 'user-disabled':
        return 'تم تعطيل هذا المستخدم';
      case 'user-not-found':
        return 'لم يتم العثور على المستخدم';
      case 'wrong-password':
        return 'كلمة المرور غير صحيحة';
      case 'email-already-in-use':
        return 'هذا البريد مستخدم من قبل';
      case 'weak-password':
        return 'كلمة المرور ضعيفة جداً';
      case 'invalid-credential':
        return 'بيانات تسجيل الدخول غير صحيحة، حاول مرة أخرى';

      case 'network-request-failed':
        return 'تحقق من اتصالك بالإنترنت';
      case 'too-many-requests':
        return 'عدد محاولات تسجيل الدخول كبير جداً. حاول لاحقاً';

      default:
        return e.message ?? 'حدث خطأ في عملية المصادقة';
    }
  }
}
