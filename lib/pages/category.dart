import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../models/category_model.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  // 1. 维护核心状态
  int _selectedIndex = 0; // 左侧选中的一级分类索引
  late List<CategoryFirst> _categoryList; // 所有分类数据
  final ScrollController _rightScrollCtrl = ScrollController(); // 右侧滚动控制器（切换分类时回到顶部）

  @override
  void initState() {
    super.initState();
    // 初始化模拟分类数据（后续替换为Dio请求真实接口）
    _categoryList = _getMockCategoryData();
  }

  @override
  void dispose() {
    _rightScrollCtrl.dispose(); // 释放滚动控制器
    super.dispose();
  }

  // 2. 模拟京东分类数据（贴合真实UI，可直接运行）
  List<CategoryFirst> _getMockCategoryData() {
    return [
      CategoryFirst(
        id: '1',
        name: '手机通讯',
        secondList: [
          CategorySecond(
            id: '101',
            name: '智能手机',
            icon:
                'https://images.unsplash.com/photo-1463288889890-a56b2853c40f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3132&q=80',
            goodsList: [
              CategoryGoods(
                  id: '1001',
                  name: 'iPhone 16 Pro 256G',
                  price: '7999',
                  img:
                      'https://images.unsplash.com/photo-1463288889890-a56b2853c40f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3132&q=80'),
              CategoryGoods(
                  id: '1002',
                  name: '华为Mate70 Pro 12+512G',
                  price: '6999',
                  img:
                      'https://images.unsplash.com/photo-1463288889890-a56b2853c40f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3132&q=80'),
            ],
          ),
          CategorySecond(
            id: '102',
            name: '运营商',
            icon:
                'https://images.unsplash.com/photo-1463288889890-a56b2853c40f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3132&q=80',
            goodsList: [
              CategoryGoods(
                  id: '1003',
                  name: '中国移动5G套餐',
                  price: '39',
                  img:
                      'https://images.unsplash.com/photo-1463288889890-a56b2853c40f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3132&q=80'),
            ],
          ),
        ],
      ),
      CategoryFirst(
        id: '2',
        name: '电脑办公',
        secondList: [
          CategorySecond(
            id: '201',
            name: '笔记本',
            icon:
                'https://images.unsplash.com/photo-1454496522488-7a8e488e8606?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2952&q=80',
            goodsList: [
              CategoryGoods(
                  id: '2001',
                  name: 'MacBook Pro 14寸',
                  price: '12999',
                  img:
                      'https://images.unsplash.com/photo-1463288889890-a56b2853c40f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3132&q=80'),
            ],
          ),
        ],
      ),
      CategoryFirst(
        id: '3',
        name: '酒水饮料',
        secondList: [
          CategorySecond(
            id: '201',
            name: '笔记本',
            icon:
                'https://images.unsplash.com/photo-1454496522488-7a8e488e8606?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2952&q=80',
            goodsList: [
              CategoryGoods(
                  id: '2001',
                  name: 'MacBook Pro 14寸',
                  price: '12999',
                  img:
                      'https://images.unsplash.com/photo-1463288889890-a56b2853c40f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3132&q=80'),
            ],
          ),
        ],
      ),
      CategoryFirst(
        id: '4',
        name: '家用电器',
        secondList: [
          CategorySecond(
            id: '201',
            name: '笔记本',
            icon:
                'https://images.unsplash.com/photo-1454496522488-7a8e488e8606?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2952&q=80',
            goodsList: [
              CategoryGoods(
                  id: '2001',
                  name: 'MacBook Pro 14寸',
                  price: '12999',
                  img:
                      'https://images.unsplash.com/photo-1463288889890-a56b2853c40f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3132&q=80'),
            ],
          ),
        ],
      ),
      CategoryFirst(
        id: '5',
        name: '母婴用品',
        secondList: [
          CategorySecond(
            id: '201',
            name: '尿片',
            icon:
                'https://images.unsplash.com/photo-1454496522488-7a8e488e8606?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2952&q=80',
            goodsList: [
              CategoryGoods(
                  id: '2001',
                  name: '纸尿片',
                  price: '12999',
                  img:
                      'https://images.unsplash.com/photo-1463288889890-a56b2853c40f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3132&q=80'),
            ],
          ),
        ],
      ),
      CategoryFirst(
        id: '6',
        name: '食品生鲜',
        secondList: [
          CategorySecond(
            id: '201',
            name: '笔记本',
            icon:
                'https://images.unsplash.com/photo-1454496522488-7a8e488e8606?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2952&q=80',
            goodsList: [
              CategoryGoods(
                  id: '2001',
                  name: 'MacBook Pro 14寸',
                  price: '12999',
                  img:
                      'https://images.unsplash.com/photo-1463288889890-a56b2853c40f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3132&q=80'),
            ],
          ),
        ],
      ),
      CategoryFirst(
        id: '7',
        name: '男装女装',
        secondList: [
          CategorySecond(
            id: '201',
            name: '笔记本',
            icon:
                'https://images.unsplash.com/photo-1454496522488-7a8e488e8606?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2952&q=80',
            goodsList: [
              CategoryGoods(
                  id: '2001',
                  name: 'MacBook Pro 14寸',
                  price: '12999',
                  img:
                      'https://images.unsplash.com/photo-1463288889890-a56b2853c40f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3132&q=80'),
            ],
          ),
        ],
      ),
      CategoryFirst(
        id: '8',
        name: '数码配件',
        secondList: [
          CategorySecond(
            id: '201',
            name: '笔记本',
            icon:
                'https://images.unsplash.com/photo-1454496522488-7a8e488e8606?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2952&q=80',
            goodsList: [
              CategoryGoods(
                  id: '2001',
                  name: 'MacBook Pro 14寸',
                  price: '12999',
                  img:
                      'https://images.unsplash.com/photo-1463288889890-a56b2853c40f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3132&q=80'),
            ],
          ),
        ],
      ),
      CategoryFirst(
        id: '9',
        name: '家居家装',
        secondList: [
          CategorySecond(
            id: '201',
            name: '笔记本',
            icon:
                'https://images.unsplash.com/photo-1454496522488-7a8e488e8606?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2952&q=80',
            goodsList: [
              CategoryGoods(
                  id: '2001',
                  name: 'MacBook Pro 14寸',
                  price: '12999',
                  img:
                      'https://images.unsplash.com/photo-1463288889890-a56b2853c40f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3132&q=80'),
            ],
          ),
        ],
      ),
      CategoryFirst(
        id: '10',
        name: '美妆个护',
        secondList: [
          CategorySecond(
            id: '201',
            name: '笔记本',
            icon:
                'https://images.unsplash.com/photo-1454496522488-7a8e488e8606?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2952&q=80',
            goodsList: [
              CategoryGoods(
                  id: '2001',
                  name: 'MacBook Pro 14寸',
                  price: '12999',
                  img:
                      'https://images.unsplash.com/photo-1463288889890-a56b2853c40f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3132&q=80'),
            ],
          ),
        ],
      ),
      CategoryFirst(
        id: '11',
        name: '珠宝饰品',
        secondList: [
          CategorySecond(
            id: '201',
            name: '笔记本',
            icon:
                'https://images.unsplash.com/photo-1454496522488-7a8e488e8606?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2952&q=80',
            goodsList: [
              CategoryGoods(
                  id: '2001',
                  name: 'MacBook Pro 14寸',
                  price: '12999',
                  img:
                      'https://images.unsplash.com/photo-1463288889890-a56b2853c40f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3132&q=80'),
            ],
          ),
        ],
      ),
      CategoryFirst(
        id: '12',
        name: '健身器材',
        secondList: [
          CategorySecond(
            id: '201',
            name: '笔记本',
            icon:
                'https://images.unsplash.com/photo-1454496522488-7a8e488e8606?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2952&q=80',
            goodsList: [
              CategoryGoods(
                  id: '2001',
                  name: 'MacBook Pro 14寸',
                  price: '12999',
                  img:
                      'https://images.unsplash.com/photo-1463288889890-a56b2853c40f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3132&q=80'),
            ],
          ),
        ],
      ),
      CategoryFirst(
        id: '13',
        name: '宠物用品',
        secondList: [
          CategorySecond(
            id: '201',
            name: '笔记本',
            icon:
                'https://images.unsplash.com/photo-1454496522488-7a8e488e8606?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2952&q=80',
            goodsList: [
              CategoryGoods(
                  id: '2001',
                  name: 'MacBook Pro 14寸',
                  price: '12999',
                  img:
                      'https://images.unsplash.com/photo-1463288889890-a56b2853c40f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3132&q=80'),
            ],
          ),
        ],
      ),
    ];
  }

  // 3. 左侧一级分类点击事件
  void _onFirstCategoryTap(int index) {
    if (_selectedIndex == index) return; // 点击当前选中项，不做操作
    setState(() {
      _selectedIndex = index;
    });
    // 切换分类后，右侧滚动到顶部
    _rightScrollCtrl.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    // 京东分类页无AppBar，直接用Scaffold包裹核心布局
    return Scaffold(
      // 使用 SafeArea 避免和系统底部区域冲突，防止 RenderFlex 溢出
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ========== 左侧：一级分类导航 ==========
            _buildLeftFirstCategory(),
            // ========== 右侧：二级分类+商品内容区 ==========
            _buildRightSecondContent(),
          ],
        ),
      ),
    );
  }

  // 构建左侧一级分类导航
  Widget _buildLeftFirstCategory() {
    // 固定宽度100.w，高度占满屏幕，可垂直滚动
    return SizedBox(
      width: 100.w,
      height: double.infinity,
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(), // 滚动效果更贴合移动端
        child: ListView.builder(
          shrinkWrap: true, // 自适应高度，避免和外层SingleChildScrollView冲突
          physics: const NeverScrollableScrollPhysics(), // 禁止内部滚动，由外层统一控制
          itemCount: _categoryList.length,
          itemBuilder: (context, index) {
            final category = _categoryList[index];
            final isSelected = _selectedIndex == index;
            // 用InkWell实现点击+水波纹效果，贴合Flutter Material风格
            return InkWell(
              onTap: () => _onFirstCategoryTap(index),
              // 选中态：京东红背景+白色文字；未选中：白底+黑字
              child: Container(
                width: double.infinity,
                height: 60.h,
                alignment: Alignment.center,
                // color: isSelected ? Colors.white : const Color.fromARGB(255, 170, 169, 169),
                child: Text(
                  category.name,
                  style: TextStyle(
                    color: isSelected ? const Color.fromARGB(255, 215, 73, 63) : Colors.black87,
                    fontSize: 14.sp,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // 构建右侧二级分类+商品内容区
  Widget _buildRightSecondContent() {
    // 占满剩余屏幕宽度，高度占满屏幕，可上下滚动
    return Expanded(
      child: SingleChildScrollView(
        controller: _rightScrollCtrl,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 二级分类宫格（京东风格：4列宫格，带图标+文字）
            _buildSecondCategoryGrid(),
            SizedBox(height: 20.h),
            // 分类下的推荐商品列表
            _buildCategoryGoodsList(),
          ],
        ),
      ),
    );
  }

  // 构建二级分类宫格（4列）
  Widget _buildSecondCategoryGrid() {
    final secondList = _categoryList[_selectedIndex].secondList;
    // 若无二级分类，显示空布局
    if (secondList.isEmpty) {
      return const SizedBox();
    }
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4, // 4列宫格，贴合京东UI
      crossAxisSpacing: 10.w,
      mainAxisSpacing: 15.h,
      childAspectRatio: 1, // 宽高比1:1，正方形宫格
      children: secondList.map(
        (second) {
          return GestureDetector(
            onTap: () {
              // 跳转到二级分类的商品列表页（结合go_router，传递分类ID）
              context.go('/category/goods?firstId=${_categoryList[_selectedIndex].id}&secondId=${second.id}');
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 二级分类图标（圆角）
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.network(
                    second.icon,
                    width: 40.w,
                    height: 40.h,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // 图标加载失败的兜底布局
                      return Container(
                        width: 40.w,
                        height: 40.h,
                        color: Colors.grey.shade200,
                        alignment: Alignment.center,
                        child: const Icon(Icons.category, color: Colors.grey),
                      );
                    },
                  ),
                ),
                SizedBox(height: 5.h),
                // 二级分类名称（单行省略）
                Text(
                  second.name,
                  style: TextStyle(fontSize: 12.sp),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ).toList(),
    );
  }

  // 构建分类下的推荐商品列表
  Widget _buildCategoryGoodsList() {
    final secondList = _categoryList[_selectedIndex].secondList;
    // 合并所有二级分类的推荐商品（京东风格：分类下展示热门商品）
    List<CategoryGoods> allGoods = [];
    for (var second in secondList) {
      allGoods.addAll(second.goodsList);
    }
    if (allGoods.isEmpty) {
      return Center(
        child: Text(
          '暂无推荐商品',
          style: TextStyle(color: Colors.grey, fontSize: 14.sp),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _categoryList[_selectedIndex].name,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.h),
        ...allGoods.map((goods) {
          return GestureDetector(
            onTap: () {
              // 跳转到商品详情页（复用之前的goods/:id路由）
              context.go('/goods/${goods.id}');
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 10.h),
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
                boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 2)],
              ),
              child: Row(
                children: [
                  // 商品图片
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4.r),
                    child: Image.network(
                      goods.img,
                      width: 80.w,
                      height: 80.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  // 商品名称+价格
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          goods.name,
                          style: TextStyle(fontSize: 14.sp),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          '¥${goods.price}',
                          style: TextStyle(color: Colors.red, fontSize: 16.sp, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}
