import 'package:flutter/material.dart';

import '../../../Common/MyNotification/index.dart';

/// 其他登录方法
class OtherLoginMethod extends StatefulWidget {
  const OtherLoginMethod({Key? key}) : super(key: key);

  @override
  State<OtherLoginMethod> createState() => _OtherLoginMethodState();
}

class _OtherLoginMethodState extends State<OtherLoginMethod> {
  /// 几种登录的方式的列表
  final List _loginMethod = [
    {
      "title": "wechat",
      "icon": Icons.wechat,
    },
    {
      "title": "facebook",
      "icon": Icons.facebook,
    },
    {
      "title": "twitter",
      "icon": Icons.account_balance,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ButtonBar(
        alignment: MainAxisAlignment.center,
        children: _loginMethod
            .map((item) => Builder(builder: (context) {
                  return IconButton(
                      icon: Icon(item['icon'],
                          color: Theme.of(context).iconTheme.color),
                      onPressed: () {
                        //TODO: 第三方登录方法
                        MyInfoDialog.showBottomMessage(
                            context, '${item['title']}登录');
                      });
                }))
            .toList(),
      )
    ]);
  }
}
