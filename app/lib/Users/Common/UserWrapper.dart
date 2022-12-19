import 'package:flutter/material.dart';
import "dart:ui";

import '../../Common/MyNotification/index.dart';

/// 登陆注册页面的包装
class UserLoginLoutWrapper extends StatefulWidget {
  const UserLoginLoutWrapper(
      {Key? key,
      required this.title,
      required this.sonWidget,
      required this.imageUrl})
      : super(key: key);

  final String title;
  final String imageUrl;
  final Widget sonWidget; // 要被封装的子组件

  @override
  State<UserLoginLoutWrapper> createState() => _UserLoginLoutWrapperState();
}

class _UserLoginLoutWrapperState extends State<UserLoginLoutWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
              onPressed: () {},
              tooltip: "share",
              icon: const Icon(Icons.share)),
          PopupMenuButton(
            itemBuilder: (context) => <PopupMenuItem<String>>[
              PopupMenuItem<String>(
                value: "content",
                child: TextButton(
                  onPressed: () {
                    MyInfoDialog.showAuthorInfo(context);
                  },
                  child: const Text("About"),
                ),
              ),
              PopupMenuItem<String>(
                value: "money",
                child: TextButton(
                  onPressed: () {
                    MyInfoDialog.showContributeMoney(context);
                  },
                  child: const Text("contribute money"),
                ),
              )
            ],
          )
        ],
      ),
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(widget.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Center(
            child: ClipRect(
          //背景过滤器
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Opacity(
              opacity: 0.2,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
          ),
        )),
        widget.sonWidget,
      ]),
    );
  }
}
