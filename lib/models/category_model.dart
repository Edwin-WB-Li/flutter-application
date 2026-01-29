// 一级分类模型
class CategoryFirst {
  final String id; // 一级分类ID
  final String name; // 一级分类名称
  final List<CategorySecond> secondList; // 对应的二级分类列表

  CategoryFirst({
    required this.id,
    required this.name,
    required this.secondList,
  });

  // 从JSON解析（后续对接接口用）
  factory CategoryFirst.fromJson(Map<String, dynamic> json) {
    var secondListJson = json['secondList'] as List;
    List<CategorySecond> secondList =
        secondListJson.map((e) => CategorySecond.fromJson(e as Map<String, dynamic>)).toList();
    return CategoryFirst(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      secondList: secondList,
    );
  }
}

// 二级分类模型
class CategorySecond {
  final String id; // 二级分类ID
  final String name; // 二级分类名称
  final String icon; // 二级分类图标（京东分类有图标，可选）
  final List<CategoryGoods> goodsList; // 二级分类下的推荐商品

  CategorySecond({
    required this.id,
    required this.name,
    required this.icon,
    required this.goodsList,
  });

  factory CategorySecond.fromJson(Map<String, dynamic> json) {
    var goodsListJson = json['goodsList'] as List;
    List<CategoryGoods> goodsList =
        goodsListJson.map((e) => CategoryGoods.fromJson(e as Map<String, dynamic>)).toList();
    return CategorySecond(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      icon: json['icon'] ?? '',
      goodsList: goodsList,
    );
  }
}

// 分类下的推荐商品模型（和首页商品模型通用，可后续合并）
class CategoryGoods {
  final String id;
  final String name;
  final String price;
  final String img;

  CategoryGoods({
    required this.id,
    required this.name,
    required this.price,
    required this.img,
  });

  factory CategoryGoods.fromJson(Map<String, dynamic> json) {
    return CategoryGoods(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      price: json['price'] ?? '',
      img: json['img'] ?? '',
    );
  }
}
