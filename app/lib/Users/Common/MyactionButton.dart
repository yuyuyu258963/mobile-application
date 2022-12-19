import 'package:flutter/material.dart';

/// 统一登录、注册、重置密码按钮的样式
class MyActionButton extends StatefulWidget {
  MyActionButton(
      {Key? key,
      required this.verify,
      required this.btnText,
      this.btnColor = Colors.green,
      this.bntHeight = 45,
      this.btnWidth = 300})
      : super(key: key);

  final Function()? verify;
  final String btnText;
  late double bntHeight, btnWidth;
  late Color btnColor;

  @override
  State<MyActionButton> createState() => _MyActionButtonState();
}

class _MyActionButtonState extends State<MyActionButton> {
  @override
  Widget build(BuildContext context) {
    return Align(
      child: SizedBox(
        height: widget.bntHeight,
        width: widget.btnWidth,
        child: ElevatedButton(
          style: ButtonStyle(
              // 设置圆角
              backgroundColor: BtnColor(primary: widget.btnColor),
              shape: MaterialStateProperty.all(const StadiumBorder(
                  side: BorderSide(style: BorderStyle.none)))),
          onPressed: widget.verify,
          child: Text(widget.btnText,
              style: Theme.of(context).primaryTextTheme.headline5),
        ),
      ),
    );
  }
}

// 按钮的颜色
class BtnColor extends MaterialStateProperty<Color?> {
  BtnColor({this.primary = Colors.blueAccent});

  late Color primary;

  @override
  Color? resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.hovered)) {
      return primary.withOpacity(0.04);
    }
    if (states.contains(MaterialState.focused) ||
        states.contains(MaterialState.pressed)) {
      return primary.withOpacity(0.12);
    }
    return primary;
  }
}
