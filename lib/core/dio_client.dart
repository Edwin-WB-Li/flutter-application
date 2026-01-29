import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dio_exception.dart'; // 后续创建自定义异常
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Dio网络请求封装类 - 全局单例
class HttpManager {
  // 全局单例实例
  static final HttpManager _instance = HttpManager._internal();
  factory HttpManager() => _instance;
  late Dio _dio;
  static String baseUrl = dotenv.env['API_BASE_URL'] ?? 'http://nest-api.weibin.xyz';
  // 私有构造方法 - 初始化Dio
  HttpManager._internal() {
    // 1. 初始化Dio基础配置
    BaseOptions options = BaseOptions(
      // 从环境工具类获取基础地址（多环境自动切换）
      baseUrl: baseUrl,
      // 超时配置
      connectTimeout: const Duration(seconds: 10), // 连接超时
      receiveTimeout: const Duration(seconds: 10), // 接收超时
      sendTimeout: const Duration(seconds: 10), // 发送超时
      // 默认请求头
      headers: {
        'Content-Type': 'application/json;charset=utf-8',
        'Accept': 'application/json',
      },
      // 响应数据类型：json
      responseType: ResponseType.json,
    );

    // 2. 创建Dio实例
    _dio = Dio(options);

    // 3. 添加拦截器（请求/响应/错误）
    _addInterceptors();
  }

  // 添加Dio拦截器
  void _addInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(
        // 请求拦截：发送请求前执行（加Token、打印日志、修改请求头等）
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
      // 开发环境打印请求日志
      // if (EnvUtils.isDev) {
      print('【请求】[${options.method}] ${options.uri}');
      print('【请求头】${options.headers}');
      if (options.data != null) print('【请求参数】${options.data}');
      // }

      // 自动添加Token（从本地存储获取，登录后才有）
      _addTokenToHeader(options);

      handler.next(options); // 继续执行请求
    },
        // 响应拦截：请求成功后执行（统一解析数据、处理业务错误）
        onResponse: (Response response, ResponseInterceptorHandler handler) {
      // 统一解析响应数据（适配京东这类接口的通用格式：{code:200, message:"成功", data:{...}}）
      Map<String, dynamic> resData = response.data is String ? json.decode(response.data) : response.data;
      int code = resData['code'] ?? 400;
      String message = resData['message'] ?? '请求失败';
      dynamic data = resData['data'];

      // 业务成功：code=200（根据实际接口规范修改）
      if (code == 200) {
        handler.resolve(Response(
          requestOptions: response.requestOptions,
          data: data, // 上层直接获取data，无需再解析code/message
          statusCode: response.statusCode,
        ));
      } else {
        // 业务错误：抛出自定义异常
        handler.reject(
          DioException(
            requestOptions: response.requestOptions,
            error: AppException(code: code, message: message),
            response: response,
          ),
          true,
        );
      }
    },
        // 错误拦截：请求失败时执行（统一处理网络错误、状态码错误）
        onError: (DioException e, ErrorInterceptorHandler handler) {
      // 开发环境打印错误日志
      // if (EnvUtils.isDev) {
      print('【错误】[${e.requestOptions.method}] ${e.requestOptions.uri}');
      print('【错误类型】${e.type} | 【错误信息】${e.message}');
      // }

      // 统一转换为自定义异常
      AppException exception = _convertDioErrorToAppException(e);
      // 全局提示错误信息（可选，可让上层自定义）
      EasyLoading.showError(exception.message);

      handler.reject(DioException(
        requestOptions: e.requestOptions,
        error: exception,
        response: e.response,
      ));
    }));
  }

  /// 给请求头添加Token（从SharedPreferences获取）
  Future<void> _addTokenToHeader(RequestOptions options) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token'; // JWT Token格式，可根据接口修改
      }
    } catch (e) {
      // if (EnvUtils.isDev) print('【Token添加失败】$e');
      print('【Token添加失败】$e');
    }
  }

  /// 将Dio原生错误转换为自定义AppException
  AppException _convertDioErrorToAppException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return AppException(code: 500, message: '网络连接超时，请检查网络');
      case DioExceptionType.sendTimeout:
        return AppException(code: 500, message: '请求发送超时，请稍后重试');
      case DioExceptionType.receiveTimeout:
        return AppException(code: 500, message: '响应接收超时，请稍后重试');
      case DioExceptionType.connectionError:
        return AppException(code: 500, message: '网络连接失败，请检查网络');
      case DioExceptionType.cancel:
        return AppException(code: 500, message: '请求已取消');
      case DioExceptionType.badResponse:
        // 状态码错误：401/403/404/500等
        int statusCode = e.response?.statusCode ?? 500;
        switch (statusCode) {
          case 401:
            // 401未授权：可在这里处理跳转到登录页（后续扩展）
            return AppException(code: 401, message: '登录已过期，请重新登录');
          case 403:
            return AppException(code: 403, message: '暂无权限访问该资源');
          case 404:
            return AppException(code: 404, message: '请求资源不存在');
          case 500:
            return AppException(code: 500, message: '服务器内部错误，请稍后重试');
          default:
            return AppException(code: statusCode, message: '请求失败，状态码：$statusCode');
        }
      default:
        return AppException(code: 400, message: e.message ?? '网络请求失败，请稍后重试');
    }
  }

  /// 封装GET请求
  /// [url]：接口路径（无需加baseUrl）
  /// [params]：请求参数（queryParameters）
  /// [showLoading]：是否显示加载弹窗（默认true）
  /// [cancelToken]：取消请求的token（可选）
  Future<T> get<T>(
    String url, {
    Map<String, dynamic>? params,
    bool showLoading = true,
    CancelToken? cancelToken,
  }) async {
    try {
      if (showLoading) EasyLoading.show(status: 'Loading...');
      Response response = await _dio.get(
        url,
        queryParameters: params,
        cancelToken: cancelToken,
      );
      return response.data as T;
    } catch (e) {
      rethrow; // 抛出自定义异常，让上层处理
    } finally {
      if (showLoading) EasyLoading.dismiss();
    }
  }

  /// 封装POST请求
  /// [url]：接口路径
  /// [data]：请求体参数
  /// [params]：url拼接参数（queryParameters）
  /// [showLoading]：是否显示加载弹窗（默认true）
  /// [cancelToken]：取消请求的token（可选）
  Future<T> post<T>(
    String url, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? params,
    bool showLoading = true,
    CancelToken? cancelToken,
  }) async {
    try {
      if (showLoading) EasyLoading.show(status: 'Loading...');
      Response response = await _dio.post(
        url,
        data: data,
        queryParameters: params,
        cancelToken: cancelToken,
      );
      return response.data as T;
    } catch (e) {
      rethrow;
    } finally {
      if (showLoading) EasyLoading.dismiss();
    }
  }

  /// 扩展：设置全局Token（登录后调用）
  Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_token', token);
  }

  /// 扩展：移除Token（登出后调用）
  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_token');
  }

  /// 扩展：获取Dio原生实例（特殊场景使用）
  Dio get dio => _dio;
}

// 全局快捷实例（上层调用更简洁）
final httpManager = HttpManager();
