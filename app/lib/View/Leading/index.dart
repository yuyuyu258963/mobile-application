import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  int count = 3;

  startTime() async {
    //设置启动图生效时间
    Duration duration = const Duration(seconds: 2);
    Timer(duration, () {
      // 空等1秒之后再计时
      _timer = Timer.periodic(const Duration(milliseconds: 1000), (v) {
        count--;
        if (count == 0) {
          navigationPage();
        } else {
          setState(() {});
        }
      });
      // return _timer;
    });
  }

  /// 页面跳转接口
  void navigationPage() {
    _timer.cancel();
    Navigator.of(context).pushReplacementNamed('login');//要跳转的页面
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: const Alignment(1.0, -1.0), // 右上角对齐
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: AnimatedSwitcher(
              switchInCurve: Curves.easeIn,
              transitionBuilder: (child, animation) =>
                  ScaleTransition(scale: animation, child: child),
              duration: const Duration(milliseconds: 400),
              child: SizedBox(
                /// 要设置key 才能监控到图片的变化
                key: ValueKey<int>(count),
                  width: double.infinity,
                  height: double.infinity,
                  child: Image.asset(
                    "images/ad/ad_${count}.png", //广告图
                    gaplessPlayback: true,
                    fit: BoxFit.fill,
                  ))),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 30.0, 10.0, 0.0),
          child: ElevatedButton(
            onPressed: () {
              navigationPage();
            },
            child: Text(
              "$count 跳过广告",
              style: const TextStyle(color: Colors.white, fontSize: 12.0),
            ),
          ),
        ),
      ],
    );
  }
}
