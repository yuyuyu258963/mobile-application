import 'package:app/Users/reSetPassword/reSetPassword.dart';
import 'package:flutter/material.dart';

import '../Common/UserWrapper.dart';

/// 忘记密码的界面
class MyRestPasswordPage extends StatefulWidget {
  const MyRestPasswordPage({Key? key}) : super(key: key);

  @override
  State<MyRestPasswordPage> createState() => _MyRestPasswordPageState();
}

class _MyRestPasswordPageState extends State<MyRestPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return const UserLoginLoutWrapper(
      title: '密码重置',
      sonWidget: ResetUserPassword(),
      imageUrl: "images/back_5.jpg",
    );
  }
}
