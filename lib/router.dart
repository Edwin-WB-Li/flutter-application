import 'package:flutter/material.dart';
import 'package:flutter_application/pages/user/login.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/home/home.dart';
import 'pages/root_layout.dart';
import 'pages/category/category.dart';
import 'pages/cart/cart.dart';
import 'pages/mine/mine.dart';
import 'pages/goods/goods_detail.dart';

final GoRouter router = GoRouter(
  // 初始页面
  initialLocation: '/home',
  // 全局重定向（路由拦截核心）
  redirect: (BuildContext context, GoRouterState state) async {
    // 1. 获取目标路由路径
    final String targetPath = state.uri.path;
    // 2. 白名单：登录/注册页面，不做拦截
    final List<String> whiteList = ['/login', '/register', '/home', '/category'];

    if (whiteList.contains(targetPath)) return null;

    // 3. 核心逻辑：仅拦截购物车页面 /cart
    if (targetPath == '/cart' || targetPath == '/mine') {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      final bool isLogin = token != null && token.isNotEmpty;
      // 判断登录状态
      if (!isLogin) {
        // 未登录：跳转到登录页
        return '/login';
      }
    }
    // 其他页面/已登录：放行
    return null;
  },
  routes: [
    // ShellRoute：实现底部 Tab 嵌套路由（核心！）
    ShellRoute(
      builder: (context, state, child) {
        // 底部 Tab 的根布局
        return RootLayout(child: child);
      },
      routes: [
        // 首页路由
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomePage(),
        ),
        // 分类路由
        GoRoute(
          path: '/category',
          builder: (context, state) => const CategoryPage(),
        ),
        // 购物车路由
        GoRoute(
          path: '/cart',
          builder: (context, state) => const CartPage(),
        ),
        // 我的路由
        GoRoute(
          path: '/mine',
          builder: (context, state) => const MinePage(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginPage(),
        ),
      ],
    ),
    // 商品详情页（跳转路由，无 Tab）
    GoRoute(
      path: '/goods/:id',
      builder: (context, state) {
        final goodsId = state.pathParameters['id']!;
        return GoodsDetailPage(goodsId: goodsId);
      },
    ),
  ],
);
