import 'package:flutter/material.dart';

import '../Common/UserWrapper.dart';
import 'login.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({Key? key}) : super(key: key);

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  @override
  Widget build(BuildContext context) {
    return const UserLoginLoutWrapper(
      title: '登录',
      sonWidget: UserLogin(),
      imageUrl: "images/back_8.jpg",
    );
  }
}
