import 'package:flutter/material.dart';

// 统一用户的邮箱输入
class MyEmailInputField extends StatelessWidget {
  MyEmailInputField(
      {Key? key,
      required this.changeEmail,
      this.inputFormatter = "邮箱",
      this.initialValue = ""})
      : super(key: key);
  final void Function(String?)? changeEmail;
  late String inputFormatter, initialValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(labelText: inputFormatter),
      validator: (v) {
        var emailReg = RegExp(
            r"[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?");
        if (!emailReg.hasMatch(v!)) {
          return '请输入正确的邮箱地址';
        }
        return null;
      },
      onSaved: changeEmail,
    );
  }
}
