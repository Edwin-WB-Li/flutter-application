import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// 全局日志工具类
class LogUtils {
  // 私有静态实例，单例模式
  static late Logger _logger;
  static late Logger _loggerNoStack;

  // 私有构造方法，禁止外部实例化
  LogUtils._internal();

  /// 初始化日志配置（建议在 main.dart 入口调用一次）
  static void init() {
    // Release 环境关闭所有日志
    if (kReleaseMode) {
      _logger = Logger(level: Level.off);
      _loggerNoStack = Logger(level: Level.off);
      return;
    }
    // 基础配置：带堆栈信息（默认，用于调试详情）
    final basePrinter = PrettyPrinter(
      methodCount: 2, // 显示的堆栈方法数
      errorMethodCount: 8, // 错误日志堆栈数
      colors: true, // 开启控制台颜色
      printEmojis: true, // 开启表情图标
    );

    // 无堆栈配置：简洁模式，替代你原有的 loggerNoStack
    final noStackPrinter = PrettyPrinter(
      methodCount: 0, // 关闭堆栈
      colors: true,
      printEmojis: true,
    );

    _logger = Logger(printer: basePrinter);
    _loggerNoStack = Logger(printer: noStackPrinter);
  }

  // ==================== 基础日志级别（带堆栈，默认） ====================
  static void d(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  static void i(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  static void w(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  static void e(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  static void t(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.t(message, error: error, stackTrace: stackTrace);
  }

  // ==================== 简洁模式（无堆栈，替代原 loggerNoStack） ====================
  static void simpleD(dynamic message) => _loggerNoStack.d(message);
  static void simpleI(dynamic message) => _loggerNoStack.i(message);
  static void simpleW(dynamic message) => _loggerNoStack.w(message);
  static void simpleE(dynamic message) => _loggerNoStack.e(message);
  static void simpleT(dynamic message) => _loggerNoStack.t(message);
}
