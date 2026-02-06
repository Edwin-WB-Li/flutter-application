import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'router.dart';

import 'package:flutter_application/utils/log_utils.dart';

void main() async {
  // 初始化日志工具
  LogUtils.init();
  // 初始化Flutter绑定（异步操作前必备）
  WidgetsFlutterBinding.ensureInitialized();

  // 加载.env文件（指定asset路径，兼容Web）
  await dotenv.load(
    fileName: ".env",
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // 设计稿尺寸（京东移动端常用）
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Flutter 京东仿站',
          theme: ThemeData(primarySwatch: Colors.red), // 京东红主题
          routerConfig: router,
          builder: (context, child) {
            // 调用 EasyLoading.init() 并传递 child（路由页面内容）
            return EasyLoading.init()(context, child);
          },
        );
      },
    );
  }
}
