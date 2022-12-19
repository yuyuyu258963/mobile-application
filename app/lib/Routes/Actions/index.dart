import 'package:flutter/material.dart';

enum LoginSate{
  login,
  loginOut
}

/**
 * 切换用户的登录状态
 */
class LoginStateController{
  LoginSate current = LoginSate.loginOut;  // 记录当前的登录状态
  /**
   * 用户成功登出
   */
  void loginOut(){
    current = LoginSate.loginOut;
  }

  /**
   * 用户成功登录
   */
  void login(){
    current = LoginSate.login;
  }

  /**
   * 校验用户是否登录
   */
  bool verifyLogin(){
    return current == LoginSate.login;
  }
}

/**
 * 单例模式，作为全局的状态控制器
 */
LoginStateController userState = LoginStateController();
