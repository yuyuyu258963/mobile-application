import 'package:app/Routes/routes.dart';
import 'package:flutter/material.dart';

import '../View/NotFound/index.dart';

/// 路由拦截器
MaterialPageRoute myGenerateRoute(RouteSettings settings) {
  debugPrint("路由拦截器");
  final name = settings.name;
  var builder = routes[name];
  // 未配置的路由统一返回 NotFoundPage
  builder ??= (content) => const NotFoundPage(title: "未找到该页面");
  return MaterialPageRoute(builder: builder);
}
