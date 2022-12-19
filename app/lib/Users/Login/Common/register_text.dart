import 'package:flutter/material.dart';

import '../../../Routes/RouteController.dart';

// 点击注册文字行
class RegisterText extends StatelessWidget {
  const RegisterText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('没有账号?  '),
            GestureDetector(
              child:
              const Text('点击注册', style: TextStyle(color: Colors.white70)),
              onTap: () {
                RouteController.registerPage(context);
                debugPrint("点击注册");
              },
            )
          ],
        ),
      ),
    );
  }
}
