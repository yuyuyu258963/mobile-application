import 'package:flutter/material.dart';

// 动画效果的直线段特效
class MyAnimateLine extends StatefulWidget {
  final double lowerBound;
  final double upperBound;
  final Color? color;
  final double lineHeight;

  const MyAnimateLine({
    Key? key,
    this.lowerBound = 20.0,
    this.upperBound = 20.0,
    this.lineHeight = 3.0,
    this.color = Colors.red,
  }) : super(key: key);

  @override
  State<MyAnimateLine> createState() => _MyAnimateLineState();
}

class _MyAnimateLineState extends State<MyAnimateLine>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _lineWidth = 20.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        lowerBound: widget.lowerBound,
        upperBound: widget.upperBound,
        reverseDuration: const Duration(milliseconds: 1000),
        duration: const Duration(seconds: 5),
        vsync: this)
      ..addListener(() {
        setState(() {
          _lineWidth = _controller.value;
        });
      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(_controller.value.toString());
    return Padding(
        padding:  EdgeInsets.only(left: 12.0, top: 4.0),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            color: widget.color,
            width: _controller.value,
            height: widget.lineHeight,
          ),
        ));
  }
}
