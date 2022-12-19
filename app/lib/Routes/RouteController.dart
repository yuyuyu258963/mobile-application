import 'package:flutter/material.dart';

import 'Actions/index.dart';

class RouteController{
  RouteController();

  /// 登录成功后去主页面
  static loginHomePage(BuildContext context) {
    userState.login();
    // 使用 pushReplacementNamed 可以使用页面的推出动画
    // 但是无法返回到这个页面
    Navigator.of(context).pushReplacementNamed("homePage");
  }

  /// 去注册页面
  static registerPage(BuildContext context) {
    // pushNamed 无动画效果
    // 提供返回到该页面
    Navigator.of(context).pushNamed("register");
  }

  /// 去登录页面
  static loginPage(BuildContext context) {
    // pushNamedAndRemoveUntil 提供页面跳转同时清空路由栈
    // 清空了 routes栈 自然也无法返回
    Navigator.of(context).pushNamedAndRemoveUntil("login", (route) => route == null);
  }

  /// 去登录页面
  static reSetPassword(BuildContext context) {
    Navigator.of(context).pushNamed("resetPassword");
  }

  /// 去未定义页面
  static gotoNotFoundPage(BuildContext context) {
    Navigator.of(context).pushNamed("NotFound");
  }

  /// 根据命名去一个页面
  static gotoAimPage(BuildContext context,String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  /// 返回上一个页面
  static goBackPage(BuildContext context){
    Navigator.pop(context);
  }

}