import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenueItem {
  late Widget icon;
  late Color color;
  late String content;

  MenueItem({
    required this.icon,
    required this.color,
    required this.content,
  });
}

List<MenueItem> menueData() {
  double iconSize = 80.0;
  return [
    MenueItem(
        icon:  Icon(Icons.image, size: iconSize,color: Color.fromARGB(
            231, 76, 175, 80)),
        color: Color.fromARGB(230, 255, 211, 100),
        content: "图片推荐🔅"),
    MenueItem(
        icon: Icon(Icons.search, size: iconSize,color: Color.fromARGB(
            187, 57, 159, 222) ),
        color: Color.fromARGB(59, 111, 241, 100),
        content: "搜索🔍"),
    MenueItem(
        icon: Icon(Icons.favorite, size: iconSize, color: Colors.redAccent,),
        color: Color.fromARGB(147, 57, 159, 222),
        content: "收藏❤"),
    MenueItem(
        icon: Icon(Icons.music_note, size: iconSize, color: Colors.lime,),
        color: Color.fromARGB(255, 255, 142, 100),
        content: "音乐🎵"),
    MenueItem(
        icon: Icon(Icons.more_horiz, size: iconSize),
        color: Color.fromARGB(119, 64, 196, 255),
        content: "功能开发中"),
  ];
}