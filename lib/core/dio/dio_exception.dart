/// 自定义网络异常类 - 包含业务码和错误信息
class AppException implements Exception {
  final int code; // 错误码：-1网络错误/401未登录/0业务错误等
  final String message; // 错误信息

  AppException({required this.code, required this.message});

  @override
  String toString() => 'AppException{code: $code, message: $message}';
}
