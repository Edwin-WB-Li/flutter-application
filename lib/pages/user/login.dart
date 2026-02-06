import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application/core/dio/dio_client.dart';
import 'package:flutter_application/core/dio/dio_exception.dart';
import 'package:flutter_application/models/user_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 表单全局Key，用于控制表单验证、重置
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;
  late final FocusNode _usernameFocusNode;
  late final FocusNode _pwdFocusNode;

  // 记住密码/密码显隐状态
  bool _rememberPwd = true;
  bool _showPwd = false;
  bool _isSubmitting = false; // 防重复提交标识

  @override
  void initState() {
    super.initState();
    // 初始化控制器和焦点
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _usernameFocusNode = FocusNode();
    _pwdFocusNode = FocusNode();
  }

  // 登录
  Future<LoginData> userLogin(String username, String password) async {
    try {
      // 调用封装的 post方法，泛型指定返回数据类型（Map/List）
      final loginData = await dio.postModel<LoginData>(
        '/user/login',
        fromJson: LoginData.fromJson, // 核心：绑定模型解析方法
        data: {
          'username': username,
          'password': password,
        },
        showLoading: true,
      );
      // 存储Token
      await dio.setToken(loginData.token);
      return loginData;
    } on AppException catch (e) {
      // 捕获自定义异常，可根据错误码做特殊处理
      print(e);
      rethrow;
      // 其他错误可自定义提示（也可依赖拦截器的全局提示）
      // EasyLoading.showError(e.msg);
    }
  }

  Future<void> _submitLogin() async {
    if (_isSubmitting || !(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    try {
      // 去除输入空格，标准化数据
      final username = _usernameController.text.trim();
      final password = _passwordController.text.trim();

      await userLogin(username, password);
    } finally {
      // 无论成功失败，重置提交状态
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  // 手机号校验规则
  String? _usernameValidator(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return '请输入账号';
    // if (text.length != 11) return '请输入11位有效手机号';
    return null;
  }

  // 密码校验规则
  String? _pwdValidator(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return '请输入密码';
    if (text.length < 6 || text.length > 16) return '密码长度需为6-16位';
    return null;
  }

  // 释放控制器（避免内存泄漏）
  @override
  void dispose() {
    _usernameController.dispose();
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
              // 用户交互时自动校验，提升体验
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 标题组件
                  const _TitleWidget(),
                  SizedBox(height: 40.h),
                  // 账号输入框
                  _UsernameInputWidget(
                    controller: _usernameController,
                    focusNode: _usernameFocusNode,
                    validator: _usernameValidator,
                    onEditingComplete: () => FocusScope.of(context).requestFocus(_usernameFocusNode),
                  ),
                  SizedBox(height: 16.h),
                  _PwdInputWidget(
                    controller: _passwordController,
                    focusNode: _pwdFocusNode,
                    showPwd: _showPwd,
                    onTogglePwd: () => setState(() => _showPwd = !_showPwd),
                    validator: _pwdValidator,
                    onEditingComplete: _submitLogin,
                  ),
                  SizedBox(height: 12.h),
                  _ActionBarWidget(
                    rememberPwd: _rememberPwd,
                    onRememberChanged: (val) => setState(() => _rememberPwd = val!),
                  ),
                  SizedBox(height: 20.h),
                  // 登录按钮
                  _SubmitButtonWidget(
                    isSubmitting: _isSubmitting,
                    onTap: _submitLogin,
                  ),
                  SizedBox(height: 30.h),
                  // 第三方登录
                  const _ThirdPartyLoginWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// 标题组件
class _TitleWidget extends StatelessWidget {
  const _TitleWidget();

  @override
  Widget build(BuildContext context) {
    return Text(
      "用户登录",
      style: TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

// 手机号输入框组件
class _UsernameInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final FormFieldValidator<String> validator;
  final VoidCallback onEditingComplete;

  const _UsernameInputWidget({
    required this.controller,
    required this.focusNode,
    required this.validator,
    required this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      // 设置文本输入框键盘类型
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onEditingComplete: onEditingComplete,
      decoration: const InputDecoration(
        labelText: '账号',
        hintText: '请输入账号',
        prefixIcon: Icon(Icons.person),
        border: OutlineInputBorder(), // 描边样式（符合MD3）
      ),
      validator: validator,
    );
  }
}

// 密码组件
class _PwdInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool showPwd;
  final VoidCallback onTogglePwd;
  final FormFieldValidator<String> validator;
  final VoidCallback onEditingComplete;

  const _PwdInputWidget({
    required this.controller,
    required this.focusNode,
    required this.showPwd,
    required this.onTogglePwd,
    required this.validator,
    required this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: !showPwd,
      textInputAction: TextInputAction.done,
      onEditingComplete: onEditingComplete,
      decoration: InputDecoration(
        labelText: '密码',
        hintText: "请输入密码",
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(showPwd ? Icons.visibility : Icons.visibility_off),
          onPressed: onTogglePwd,
        ),
        border: const OutlineInputBorder(),
      ),
      validator: validator,
    );
  }
}

class _ActionBarWidget extends StatelessWidget {
  final bool rememberPwd;
  final ValueChanged<bool?> onRememberChanged;

  const _ActionBarWidget({
    required this.rememberPwd,
    required this.onRememberChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // 记住密码
        Row(
          children: [
            Checkbox(
              value: rememberPwd,
              onChanged: onRememberChanged,
            ),
            const Text("记住密码"),
          ],
        ),
        // 忘记密码+注册
        Row(
          children: [
            TextButton(
              onPressed: () => _showSnackBar(context, "跳转到找回密码页面"),
              child: const Text('忘记密码？', style: TextStyle(color: Colors.blue)),
            ),
            TextButton(
              onPressed: () => _showSnackBar(context, "跳转到注册页面"),
              child: const Text('注册账号？', style: TextStyle(color: Colors.blue)),
            ),
          ],
        ),
      ],
    );
  }

  // 封装SnackBar，避免重复代码
  void _showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }
}

// 登录按钮组件
class _SubmitButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final bool isSubmitting;

  const _SubmitButtonWidget({required this.onTap, required this.isSubmitting});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: ElevatedButton(
        onPressed: isSubmitting ? null : onTap,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: isSubmitting
            ? const CircularProgressIndicator(color: Colors.white)
            : Text("登录", style: TextStyle(fontSize: 18.sp)),
      ),
    );
  }
}

// 第三方登录组件
class _ThirdPartyLoginWidget extends StatelessWidget {
  const _ThirdPartyLoginWidget();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.wechat, color: Colors.green, size: 36.h),
          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("微信登录"))),
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
    );
  }
}
