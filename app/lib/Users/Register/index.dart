import 'package:app/Users/Register/register.dart';
import 'package:flutter/material.dart';

import '../Common/UserWrapper.dart';

class MyRegisterPage extends StatefulWidget {
  const MyRegisterPage({Key? key}) : super(key: key);

  @override
  State<MyRegisterPage> createState() => _MyRegisterPageState();
}

class _MyRegisterPageState extends State<MyRegisterPage> {
  @override
  Widget build(BuildContext context) {
    return const UserLoginLoutWrapper(
      title: '注册',
      sonWidget: UserRegister(),
      imageUrl: "images/back_2.png",
    );
  }
}
