import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // 轮播图数据（模拟）
  static List<String> _bannerImages = [
    'https://images.unsplash.com/photo-1434394354979-a235cd36269d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2902&q=80',
    'https://images.unsplash.com/photo-1463288889890-a56b2853c40f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3132&q=80',
    'https://images.unsplash.com/photo-1454496522488-7a8e488e8606?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2952&q=80',
  ];

  // 分类入口数据（模拟）
  static List<Map<String, String>> _categoryList = [
    {
      'icon':
          'https://images.unsplash.com/photo-1434394354979-a235cd36269d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2902&q=80',
      'name': '秒杀'
    },
    {
      'icon':
          'https://images.unsplash.com/photo-1454496522488-7a8e488e8606?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2952&q=80',
      'name': '超市'
    },
    {
      'icon':
          'https://images.unsplash.com/photo-1434394354979-a235cd36269d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2902&q=80',
      'name': '数码'
    },
    {
      'icon':
          'https://images.unsplash.com/photo-1454496522488-7a8e488e8606?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2952&q=80',
      'name': '服饰'
    },
    {
      'icon':
          'https://images.unsplash.com/photo-1434394354979-a235cd36269d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2902&q=80',
      'name': '家电'
    },
    {
      'icon':
          'https://images.unsplash.com/photo-1434394354979-a235cd36269d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2902&q=80',
      'name': '生鲜'
    },
    {
      'icon':
          'https://images.unsplash.com/photo-1454496522488-7a8e488e8606?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2952&q=80',
      'name': '充值'
    },
    {
      'icon':
          'https://images.unsplash.com/photo-1434394354979-a235cd36269d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2902&q=80',
      'name': '拼购'
    },
  ];

  // 商品列表数据（模拟）
  static List<Map<String, String>> _goodsList = [
    {
      'img':
          'https://images.unsplash.com/photo-1454496522488-7a8e488e8606?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2952&q=80',
      'name': 'iPhone 16 Pro 256G',
      'price': '7999'
    },
    {
      'img':
          'https://images.unsplash.com/photo-1434394354979-a235cd36269d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2902&q=80',
      'name': '华为 Mate70 Pro 12+512G',
      'price': '6999'
    },
    {
      'img':
          'https://images.unsplash.com/photo-1463288889890-a56b2853c40f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3132&q=80',
      'name': '小米 15 Ultra 16+1T',
      'price': '5999'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero, // 设置 ListView 内边距为 0
      children: [
        // 1. 顶部搜索栏（京东风格）
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          color: Colors.red,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 36.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: '京东秒杀 百亿补贴',
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              const Icon(Icons.qr_code, color: Colors.white),
            ],
          ),
        ),

        // 2. 轮播图
        CarouselSlider(
          options: CarouselOptions(
            height: 150.h,
            autoPlay: true,
            viewportFraction: 1.0, // 全屏轮播
          ),
          items: _bannerImages.map((img) {
            return CachedNetworkImage(
              imageUrl: img,
              fit: BoxFit.cover,
              width: double.infinity,
            );
          }).toList(),
        ),

        // 3. 分类入口（8宫格）
        GridView.count(
          shrinkWrap: true, // 自适应高度（必须！否则ListView会冲突）
          physics: const NeverScrollableScrollPhysics(), // 禁止网格滚动
          crossAxisCount: 4, // 4列
          padding: EdgeInsets.symmetric(vertical: 10.h),
          children: _categoryList.map((item) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CachedNetworkImage(
                    imageUrl: item['icon']!, width: 40.w, height: 40.h),
                SizedBox(height: 5.h),
                Text(item['name']!, style: TextStyle(fontSize: 12.sp)),
              ],
            );
          }).toList(),
        ),

        // 4. 商品列表（京东风格）
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('爆款推荐',
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 10.h),
              ..._goodsList.map((goods) {
                return GestureDetector(
                  // 跳转到商品详情页（go_router 跳转）
                  onTap: () => context
                      .go('/goods/${goods['name']!.replaceAll(' ', '_')}'),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10.h),
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.shade200, blurRadius: 2)
                      ],
                    ),
                    child: Row(
                      children: [
                        CachedNetworkImage(
                            imageUrl: goods['img']!,
                            width: 100.w,
                            height: 100.w),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(goods['name']!,
                                  style: TextStyle(fontSize: 14.sp),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis),
                              SizedBox(height: 10.h),
                              Text('¥${goods['price']}',
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ],
    );
  }
}
