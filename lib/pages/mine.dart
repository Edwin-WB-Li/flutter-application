import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_application/core/dio_client.dart';
import 'package:flutter_application/core/dio_exception.dart';
import 'package:logger/logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

var loggerNoStack = Logger(
  printer: PrettyPrinter(methodCount: 0),
);

// 首页获取商品列表
Future<void> getGoodsList() async {
  try {
    // 调用封装的 post方法，泛型指定返回数据类型（Map/List）
    Map<dynamic, dynamic> goodsList = await httpManager.post<Map>('/hitokoto/getHitokoto',
        data: {
          'page': 1,
          'size': 10,
        },
        showLoading: true);
    // // 处理数据（更新UI）
    // setState(() {
    //   _goodsList = goodsList.map((e) => GoodsModel.fromJson(e)).toList();
    // });
    loggerNoStack.t(goodsList);
  } on AppException catch (e) {
    // 捕获自定义异常，可根据错误码做特殊处理
    print(e);
    // 其他错误可自定义提示（也可依赖拦截器的全局提示）
    // EasyLoading.showError(e.msg);
  }
}

// 我的页面（基础布局）
// class MinePage extends StatefulWidget {
//   const MinePage({super.key});

//   @override
//   State<MinePage> createState() => _MinePageState();
// }

// class _MinePageState extends State<MinePage> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       // EasyLoading.show(status: 'loading...');
//       // // 3秒后隐藏
//       // Future.delayed(Duration(seconds: 1)).then((value) {
//       //   EasyLoading.dismiss();
//       // });
//       getGoodsList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     logger.d('Log message with 2 methods');

//     loggerNoStack.i('Info message');

//     loggerNoStack.w('Just a warning!');

//     logger.e('Error! Something bad happened', error: 'Test Error');

//     return const Center(child: Text('我的页面'));
//   }
// }

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  // 表单控制器
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  FocusNode focusNode = FocusNode();
  // 记住密码/密码显隐状态
  bool _rememberPwd = true;
  bool _showPwd = false;

  void _submitLogin() {
    // 表单验证
    if (_formKey.currentState!.validate()) {
      // 校验通过
      String phone = _phoneController.text.trim();
      String password = _passwordController.text.trim();
      logger.i('手机号：$phone，密码：$password，记住密码：$_showPwd');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("登录中：$phone / $password")),
      );
    }
  }

  @override
  void dispose() {
    // 释放控制器（避免内存泄漏）
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return const Center(child: Text('登录页面'));
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("用户登录", style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold)),
                  SizedBox(height: 40.h),
                  // 手机号输入框
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: '手机号',
                      hintText: '请输入手机号',
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(), // 描边样式（符合MD3）
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '请输入手机号';
                      } else if (value.length != 11) {
                        return "请输入正确的11位手机号";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  IntlPhoneField(
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    initialCountryCode: 'CN',
                    languageCode: "",
                    onChanged: (phone) {
                      print(phone.completeNumber);
                    },
                    onCountryChanged: (country) {
                      print('Country changed to: $country.name');
                    },
                  ),
                  SizedBox(height: 16.h),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_showPwd, // 是否隐藏密码
                    decoration: InputDecoration(
                      labelText: '密码',
                      hintText: "请输入密码",
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(_showPwd ? Icons.visibility : Icons.visibility_off),
                        onPressed: () => setState(() => _showPwd = !_showPwd),
                      ),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '请输入密码';
                      } else if (value.length < 6 || value.length > 16) {
                        return "密码长度需为6-16位";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Checkbox(value: _rememberPwd, onChanged: (value) => setState(() => _rememberPwd = value!)),
                          const Text("记住密码"),
                          TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("跳转到找回密码页面")));
                            },
                            child: const Text(
                              '忘记密码？',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("跳转到注册页面")));
                            },
                            child: const Text(
                              '注册账号？',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: ElevatedButton(
                      onPressed: _submitLogin,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text("登录", style: TextStyle(fontSize: 18.sp)),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.wechat, color: Colors.green, size: 36.h),
                        onPressed: () =>
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("微信登录"))),
                      ),
                      SizedBox(width: 30.h),
                      IconButton(
                        icon: Icon(Icons.tiktok, color: Colors.black, size: 36.h),
                        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("抖音登录"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
