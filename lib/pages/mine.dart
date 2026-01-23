import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_application/core/dio_client.dart';
import 'package:flutter_application/core/dio_exception.dart';

// 首页获取商品列表
Future<void> getGoodsList() async {
  try {
    // 调用封装的 post方法，泛型指定返回数据类型（Map/List）
    Map<dynamic, dynamic> goodsList =
        await httpManager.post<Map>('/hitokoto/getHitokoto',
            data: {
              'page': 1,
              'size': 10,
            },
            showLoading: true);
    // // 处理数据（更新UI）
    // setState(() {
    //   _goodsList = goodsList.map((e) => GoodsModel.fromJson(e)).toList();
    // });
    print(goodsList);
  } on AppException catch (e) {
    // 捕获自定义异常，可根据错误码做特殊处理
    print(e);
    // 其他错误可自定义提示（也可依赖拦截器的全局提示）
    // EasyLoading.showError(e.msg);
  }
}

// 我的页面（基础布局）
class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // EasyLoading.show(status: 'loading...');
      // // 3秒后隐藏
      // Future.delayed(Duration(seconds: 1)).then((value) {
      //   EasyLoading.dismiss();
      // });
      getGoodsList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('我的页面'));
  }
}
