
class Result<T> {
  final T?data;
  final String? error;
  Result.success(this.data):error=null;
  Result.failure(this.error):data=null;

  bool get isSuccess => error == null;
  bool get isFailure => error != null;
}
// error_handler.dart
abstract class IErrorHandler {
  bool canHandle(dynamic error);
  String handle(dynamic error);
}

// --------------------------
// firebase_auth_error_handler.dart

