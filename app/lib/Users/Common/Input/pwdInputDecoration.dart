import 'package:flutter/material.dart';

// 密码输入框的状态保存
class pwdInputState {
  bool isObscure = true;
  Color eyeColor = Colors.grey;

  pwdInputState(bool isObscure, Color eyeColor);

  // 设置可见状态
  void setIsObscure() {
    isObscure = !isObscure;
  }

  // 设置图标的颜色
  void setEyeColor(Color i) {
    eyeColor = i;
  }

  // 处理密码输入框图标被点击
  handelClickInputIcon(BuildContext context) {
    setIsObscure();
    eyeColor = (isObscure ? Colors.grey : Theme.of(context).iconTheme.color)!;
  }
}

/// 密码输入框
class PwdInputDecoration extends StatefulWidget {
  PwdInputDecoration({
    Key? key,
    required this.showState,
    required this.setPwdInputContent,
    required this.iconPressed,
    required this.inputTitle,
    this.emptyTip="请输入密码",
    this.initialValue="",
  }) : super(key: key);

  final String inputTitle;
  final pwdInputState showState;
  final Function(String?)? setPwdInputContent;
  final Function() iconPressed;
  late String emptyTip, initialValue;

  @override
  State<PwdInputDecoration> createState() => _PwdInputDecorationState();
}

class _PwdInputDecorationState extends State<PwdInputDecoration> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        initialValue: widget.initialValue,
        obscureText: widget.showState.isObscure, // 是否显示文字
        onSaved: widget.setPwdInputContent,
        validator: (v) {
          if (v!.isEmpty) {
            return widget.emptyTip;
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: widget.inputTitle,
            suffixIcon: IconButton(
              icon: Icon(
                !widget.showState.isObscure
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: widget.showState.eyeColor,
              ),
              onPressed: () {
                widget.iconPressed();
              },
            )));
  }
}
