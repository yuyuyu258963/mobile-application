import 'package:flutter/material.dart';

import 'animateLine.dart';

// 获得顶部的 Title 组件组
List<Widget> headTitle(String title, double lineWidth,
    {Color lineColor = Colors.red}) {
  return <Widget>[
    // 顶部留出一部分空间
    const SizedBox(
      height: kToolbarHeight,
    ),
    // Padding(
    //     padding: EdgeInsets.all(8),
    //     child: Text(
    //       title!,
    //       style: TextStyle(fontSize: 42),
    //     )),
    Padding(
      padding: const EdgeInsets.only(left: 12.0, top: 4.0),
      child: Align(
          alignment: Alignment.topLeft,
          child:ClipOval(
        child: Image.asset(
          "images/school_logo.png",
          fit: BoxFit.fill,
          width: 75,
          height: 75,
        ),
      )),
    ),

    Padding(
        padding: const EdgeInsets.only(left: 12.0, top: 5.0),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            color: lineColor,
            width: lineWidth,
            height: 3,
          ),
        )),
  ];
}
