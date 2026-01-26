import 'package:flutter/material.dart';

// 商品详情页（跳转页面）
class GoodsDetailPage extends StatelessWidget {
  final String goodsId;
  const GoodsDetailPage({super.key, required this.goodsId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('商品详情')),
      body: Center(child: Text('商品ID：$goodsId')),
    );
  }
}
