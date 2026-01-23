import 'package:go_router/go_router.dart';

import 'pages/home.dart';
import 'pages/root_layout.dart';
import 'pages/category.dart';
import 'pages/cart.dart';
import 'pages/mine.dart';
import 'pages/goods_detail.dart';

final GoRouter router = GoRouter(
  initialLocation: '/home',
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
