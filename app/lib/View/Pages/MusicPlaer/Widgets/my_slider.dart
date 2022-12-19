import 'package:flutter/material.dart';

import '../MyMp3Player.dart';

/// 音乐进度控制滑动条
class MySlider extends StatefulWidget {
  const MySlider({super.key});

  @override
  _MySliderState createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  double minV = 0.0, maxV = 100.0;
  double sliderV = 0.0;

  void changeSliderV(double v) {
    setState(() {
      if (v >= minV && v <= maxV) {
        sliderV = v;
      }
    });
  }
  /// 监听状态
  void sliderMove(double v){
    changeSliderV(100.0 * v);
    debugPrint("刷新");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myMp3Player.positionListener(sliderMove);
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
        data: SliderTheme.of(context).copyWith(
          trackHeight: 5,
          // 轨道高度
          activeTrackColor: Colors.lightBlue,
          showValueIndicator:ShowValueIndicator.always,
            // 激活的轨道颜色
          inactiveTrackColor: Color.fromARGB(36, 10, 10, 10),
          // 未激活的轨道颜色
          thumbShape: RoundSliderThumbShape(
              //  滑块形状，可以自定义
              enabledThumbRadius: 12 // 滑块大小
              ),
          thumbColor: Color.fromARGB(255, 59, 111, 230),
          // 滑块颜色
          overlayShape: RoundSliderOverlayShape(
            // 滑块外圈形状，可以自定义
            overlayRadius: 15, // 滑块外圈大小
          ),
          overlayColor: Colors.black26,
          // const 滑块外圈颜色
          valueIndicatorShape: PaddleSliderValueIndicatorShape(),
          // 标签形状，可以自定义
          activeTickMarkColor: Colors.red, // 激活的刻度颜色
        ),
        child: Row(children: [
          Expanded(
            child: Slider(
              min: minV,
              max: maxV,
              label: "$sliderV",
              value: sliderV,
              onChanged: changeSliderV,
            ),
          ),

          // Text(myMp3Player.durationMS()),
        ]));
  }
}
