// lib/core/errors/error_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class ErrorModel {
  final String message;
  final String? code;
  final Map<String, dynamic>? details;

  const ErrorModel({
    required this.message,
    this.code,
    this.details,
  });

  factory ErrorModel.fromFirebaseError(dynamic error) {
    if (error is FirebaseException) {
      return ErrorModel(
        message: error.message ?? 'حدث خطأ غير معروف',
        code: error.code,
        details: {'plugin': error.plugin},
      );
    }
    return ErrorModel(message: error.toString());
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'code': code,
    'details': details,
  };

  String get userMessage => message;
}
