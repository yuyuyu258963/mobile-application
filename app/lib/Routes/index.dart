import 'package:flutter/material.dart';
import 'MonGenerateRoute.dart';
import 'onUnknownRoute.dart';
import 'routes.dart' as RouteList;

// 我的路由配置
class MYRoutes{
  // 初始页面设置
  static String initialRoute = "adPage";
  // 路由配置列表
  static Map<String, Widget Function(BuildContext)> routes = RouteList.routes;
  //  路由拦截器
  static  MaterialPageRoute Function(RouteSettings settings) onGenerateRoute = myGenerateRoute ;
  /// 未匹配路由处理
  static MaterialPageRoute Function(RouteSettings settings)  onUnknownRoute = myOnUnKnowRoute;
}