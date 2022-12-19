import 'package:flutter/material.dart';

// 不需要校验的
class WithoutValidatorInput extends StatelessWidget {
   const WithoutValidatorInput({super.key, this.setInputContent, required this.inputDecorationPrefix});
  final void Function(String?)? setInputContent;
  final String inputDecorationPrefix;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: inputDecorationPrefix),
      validator: (v) {
        if (v == null || v.isEmpty) {
          return "请您输入内容";
        }
        return null;
      },
      onSaved: setInputContent,
    );
  }
}
