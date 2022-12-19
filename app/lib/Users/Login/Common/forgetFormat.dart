import 'package:flutter/material.dart';

import '../../../Routes/RouteController.dart';

// 忘记密码的文字
class ForgetNameString extends StatelessWidget {
  const ForgetNameString({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () {
            RouteController.reSetPassword(context);
            debugPrint("忘记密码");
          },
          child: const Text("忘记密码？",
              style: TextStyle(fontSize: 14, color: Colors.black87)),
        ),
      ),
    );
  }
}
