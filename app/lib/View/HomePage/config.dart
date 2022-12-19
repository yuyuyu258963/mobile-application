import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Common/MyNotification/index.dart';

/**
 * total get all leading config
 */
// Widget getLeading(IconData icon){
//   return CircleAvatar(
//     child: Icon(icon),
//   );
// }

class InfoListItem {
  late Widget leading;
  late Widget title;
  Function onTap = (){
    MyInfoDialog.waitingToExploitation();
  };



  InfoListItem(IconData icon, String title, [dynamic onTap] ) {
    leading = InfoListItem.getLeading(icon);
    if (onTap != null) {
      this.onTap = onTap;
    }
    this.title = Text(title);
  }

  static Widget getLeading(IconData icon) {
    return CircleAvatar(
      child: Icon(icon),
    );
  }

  Widget get listTile {
    return ListTile(
      onTap: onTap as Function()?,
      leading: leading,
      trailing: const Icon(Icons.chevron_right),
      title: title,
    );
  }
}

/**
 * get the list items
 */
List<Widget> InfoListGetter(List<Widget> data, BuildContext context) {
  data = [
    ...data,
    InfoListItem(Icons.home, "主页").listTile,
    InfoListItem(Icons.account_circle_outlined, "用户中心").listTile,
    InfoListItem(Icons.settings, "设置").listTile,
    InfoListItem(Icons.supervised_user_circle, "VIP 服务中心", (){
      MyInfoDialog.showContributeMoney(context, "成为VIP");
    }).listTile,
  ];
  return data;
}
