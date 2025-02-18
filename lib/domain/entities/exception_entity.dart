class ExceptionEntity implements Exception {
  static const UNKNOWN_ERROR = 'server_error_unknown_error';
  final String code;
  final String message;

  ExceptionEntity({this.code = UNKNOWN_ERROR, this.message = UNKNOWN_ERROR});

  @override
  String toString() {
    return 'ExceptionEntity{code: $code, message: $message}';
  }

  factory ExceptionEntity.fromException(Exception e) {
    if (e is ExceptionEntity) {
      return e;
    } else {
      return ExceptionEntity();
    }
  }
}
