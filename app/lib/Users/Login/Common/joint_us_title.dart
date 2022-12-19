import 'package:flutter/material.dart';

// 加入我们的文字部分
class JointUsTitle extends StatelessWidget {
  const JointUsTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.topLeft,
      child: Text(
        "快加入我吧~",
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
