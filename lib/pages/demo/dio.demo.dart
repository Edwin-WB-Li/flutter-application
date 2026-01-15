import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioDemo extends StatefulWidget {
  const DioDemo({super.key});
  @override
  State<DioDemo> createState() => _DioDemoState();
}

class _DioDemoState extends State<DioDemo> {
  String _result = '未请求数据';
  late Dio _dio;

  @override
  void initState() {
    super.initState();
    // 初始化Dio，配置全局参数
    _dio = Dio(BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com', // 基础地址
      connectTimeout: const Duration(seconds: 5), // 连接超时
      receiveTimeout: const Duration(seconds: 3), // 接收超时
      headers: {'Content-Type': 'application/json'}, // 全局请求头
    ));

    // 添加拦截器（统一处理请求/响应/错误）
    _dio.interceptors.add(InterceptorsWrapper(
      // 请求拦截（比如添加Token）
      onRequest: (options, handler) {
        options.headers['Authorization'] = 'Bearer your_token_here';
        handler.next(options);
      },
      // 响应拦截（统一解析数据）
      onResponse: (response, handler) {
        handler.next(response);
      },
      // 错误拦截（统一处理错误）
      onError: (DioException e, handler) {
        setState(() => _result = '拦截器捕获错误：${e.message}');
        handler.next(e);
      },
    ));
  }

  Future<void> fetchData() async {
    try {
      // GET请求
      final response = await _dio.get('/posts/1');
      setState(() {
        _result = '标题：${response.data['title']}\n内容：${response.data['body']}';
      });

      // POST请求示例
      // final postResponse = await _dio.post(
      //   '/posts',
      //   data: {'title': '测试', 'body': '测试内容', 'userId': 1},
      // );
    } on DioException catch (e) {
      // Dio 特定异常捕获
      setState(() => _result = 'Dio错误：${e.type} - ${e.message}');
    } catch (e) {
      // 通用异常捕获
      setState(() => _result = '未知异常：$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dio示例（主流方案）')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: fetchData, child: const Text('获取数据')),
            const SizedBox(height: 20),
            Text(_result),
          ],
        ),
      ),
    );
  }
}
