import 'package:flutter/material.dart';

class RotaImg extends StatefulWidget {
  RotaImg({super.key,required this.thumbnail,required this.playState});
  late String thumbnail;
  late bool playState;

  @override
  _RotaImgState createState() => _RotaImgState();
}

class _RotaImgState extends State<RotaImg> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: Duration(seconds: 500), vsync: this);
    _animation =  Tween<double>(
      begin: 0,
      end: 20,
    ).animate(_animationController)..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // 动画完成后反转
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        // 反转回初始状态时继续播放，实现无限循环
        _animationController.forward();
      }
    });
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((mag) {
      _animationController.forward();
      debugPrint("加载完成");
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.playState) {
      _animationController.stop();
    } else {
      _animationController.forward();
    }
    return RotationTransition(
        alignment: Alignment.center,
        turns: _animation,
        child:ClipOval(child: Image.network(
      widget.thumbnail,
      fit: BoxFit.fill,
    )));
  }
}
