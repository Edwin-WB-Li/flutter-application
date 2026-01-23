import 'package:flutter/material.dart';

import 'demo/cards_demo.dart';

// 分类页面（基础布局）
class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});
  @override
  Widget build(BuildContext context) {
    // return const Center(child: Text('分类页面'));
    return const CardsDemo();
  }
}