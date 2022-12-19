import 'package:flutter/material.dart';

import '../Common/MyNotification/index.dart';
import 'Login/login.dart';

class UserInfoMainPage extends StatefulWidget {
  const UserInfoMainPage({Key? key}) : super(key: key);

  @override
  State<UserInfoMainPage> createState() => _UserInfoMainPageState();
}

class _UserInfoMainPageState extends State<UserInfoMainPage>
    with SingleTickerProviderStateMixin {
  // 滑动的方式去控制页面的滑动
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 3);
    _tabController.addListener(() {
      debugPrint("切换");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.deepOrangeAccent,
          title: const Text(
            "用户注册",
            textAlign: TextAlign.center,
          ),
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
                    child: const Text("content with us"),
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
        body: TabBarView(
          controller: _tabController,
          children: const <Widget>[
            UserLogin(),
            Center(child: Text("注册")),
            Center(child: Text("找回密码")),
          ],
        ),
    );
  }
}
