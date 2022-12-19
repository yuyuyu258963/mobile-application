import 'package:flutter/material.dart';

// 要展示的用户信息列
class AuthorInfoItem{
  late Icon icon;
  late Widget title;
  late Widget subTitle;

  AuthorInfoItem(IconData i , String titleString, String subTitleString){
    icon = Icon(i);
    title = Text(titleString);
    subTitle = Text(subTitleString);
  }
  Widget getTile(){
      return ListTile(leading: icon,title: title, subtitle: subTitle);
    }
}


class AuthorInfo {
  late String name;
  late String sex;
  late String ehnic;
  late String college;
  late String major;
  late String adviser;

  // 类的初始化方法
  AuthorInfo(name, sex, ehnic, college, major, adviser);
}

/// 作者的信息
List<Widget> authorDetail = [
  AuthorInfoItem(Icons.account_circle_outlined, "姓名", "余王豪").getTile(),
  AuthorInfoItem(Icons.safety_divider_outlined, "性别", "男").getTile(),
  AuthorInfoItem(Icons.safety_divider_outlined, "名族", "汉族").getTile(),
  AuthorInfoItem(Icons.account_balance_outlined, "学院", "信息管理与人工智能学院").getTile(),
  AuthorInfoItem(Icons.account_balance_outlined, "专业", "软件工程").getTile(),
  AuthorInfoItem(Icons.abc_outlined, "学号", "200110900331").getTile(),
  AuthorInfoItem(Icons.account_circle, "指导老师", "王凌武").getTile(),
];

