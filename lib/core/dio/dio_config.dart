import 'package:flutter_dotenv/flutter_dotenv.dart';

/// 网络请求配置
class DioConfig {
  /// 基础域名（可通过环境变量区分开发/生产环境）
  static String baseUrl = dotenv.env['Api_BASE_URL'] ?? 'http://nest-api.weibin.xyz';

  /// 请求超时时间（毫秒）
  static const int connectTimeout = 10000;

  /// 响应超时时间（毫秒）
  static const int receiveTimeout = 10000;

  /// 默认请求头
  static Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}
