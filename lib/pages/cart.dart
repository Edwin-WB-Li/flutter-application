import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// 购物车页面（基础布局）
class CartPage extends StatelessWidget {
  const CartPage({super.key});
  @override
  Widget build(BuildContext context) {
    final apiUrl = dotenv.env['API_BASE_URL'] ?? '默认地址';
    print('获取到的API地址：$apiUrl'); // 控制台打印验证
    return const Center(child: Text('购物车页面'));
  }
}
