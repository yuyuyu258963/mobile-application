import 'package:flutter/material.dart';

class MyDrawerHeader extends StatelessWidget {
  MyDrawerHeader(
      {super.key,
      this.iconSize = 18.0,
      this.name = "雨树",
      this.personalizedSignature = "这个家伙很懒没有留下什么……",
      this.backImageUrl = "user_back_1.png",
      this.avtUrl = "images/Avator/avator_1.jpg"});

  late double iconSize;
  late String backImageUrl, avtUrl, personalizedSignature, name;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: DrawerHeader(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  backImageUrl,
                ),
                fit: BoxFit.cover)),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(avtUrl),
            radius: 30,
          ),
          title: Text(
            name,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          subtitle: Column(
            children: [
              buildHeadIconList(),
              const SizedBox(height: 3),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  personalizedSignature,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, color: Colors.black87),
                ),
              )
            ],
          ),
        ),
      ))
    ]);
  }

  // 图标行
  Widget buildHeadIconList() {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      Icon(
        Icons.sunny,
        size: iconSize,
        color: Colors.amberAccent,
      ),
      Icon(
        Icons.sunny,
        size: iconSize,
        color: Colors.amberAccent,
      ),
      Icon(
        Icons.more_horiz,
        size: iconSize,
        color: Colors.amberAccent,
      ),
      Icon(
        Icons.edit,
        size: iconSize,
        color: Colors.black,
      ),
      Icon(
        Icons.vertical_split_rounded,
        size: iconSize,
        color: Colors.black,
      ),
      Icon(
        Icons.generating_tokens_outlined,
        size: iconSize,
        color: Colors.black,
      ),
    ]);
  }
}
