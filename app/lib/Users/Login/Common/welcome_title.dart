import 'package:flutter/material.dart';

/// 欢迎标头
class WelcomeTitle extends StatelessWidget {
  const WelcomeTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.topLeft,
      child: Text(
        "登录后 更精彩",
        style: TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
