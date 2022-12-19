import 'package:flutter/material.dart';

import '../View/NotFound/index.dart';

/// 路由匹配不到的时候，统一翻返回一个错误页面
MaterialPageRoute<dynamic> myOnUnKnowRoute(RouteSettings settings){
  return MaterialPageRoute(builder:(content)  => const NotFoundPage(title: "Not Found Page",));
}