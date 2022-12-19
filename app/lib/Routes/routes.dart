import 'package:flutter/material.dart';

import '../Users/Login/index.dart';
import '../Users/Register/index.dart';
import '../Users/reSetPassword/index.dart';
import '../View/HomePage/index.dart';
import '../View/Leading/index.dart';
import '../View/NotFound/index.dart';

/// 自己的路由配置
Map<String, Widget Function(BuildContext)> routes = {
  /// 初始界面
  "initPage": (context, {arguments}) => const NotFoundPage(title: "initPage"),
  /// 非法访问页面
  "NotFoundPage": (context) => const NotFoundPage(title: "222"),

  /// 广告页面
  "adPage": (context) => const SplashScreen(),

  /// 用户登录界面
  "login": (context) => const MyLoginPage(),
  /// 用户注册界面
  "register": (context) => const MyRegisterPage(),
  /// 重新设置密码页
  "resetPassword": (context) => const MyRestPasswordPage(),
  /// 系统的主页面
  "homePage": (context) => const MyHomeBody(),
};