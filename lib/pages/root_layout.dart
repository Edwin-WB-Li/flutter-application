import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// 底部 Tab 根布局（复用所有 Tab 页面的底部导航）
class RootLayout extends StatefulWidget {
  final Widget child;
  const RootLayout({super.key, required this.child});

  @override
  State<RootLayout> createState() => _RootLayoutState();
}

class _RootLayoutState extends State<RootLayout> {
  // Tab 配置
  final List<BottomNavigationBarItem> _tabs = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
    const BottomNavigationBarItem(icon: Icon(Icons.category), label: '分类'),
    const BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: '购物车'),
    const BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
  ];

  // 当前选中的 Tab 索引
  int _currentIndex = 0;

  // Tab 对应的路由地址
  final List<String> _tabRoutes = ['/home', '/category', '/cart', '/mine'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 子页面内容（由路由决定）
      body: widget.child,
      // 底部 TabBar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed, // 固定4个Tab（避免挤在一起）
        selectedItemColor: Colors.red, // 选中颜色（京东红）
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() => _currentIndex = index);
          // 路由跳转（go_router 核心）
          context.go(_tabRoutes[index]);
        },
        items: _tabs,
      ),
    );
  }
}
