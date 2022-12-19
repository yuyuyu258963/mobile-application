import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../Common/MyNotification/index.dart';
import '../../../../Provider/Stores/userState.dart';
import '../../../../Routes/RouteController.dart';
import '../../config.dart';
import 'my_drawer_header.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: Column(
        children: <Widget>[
          MyDrawerHeader(),
          Expanded(
              child: Column(
            children: [
              ...InfoListGetter([], context),
            ],
          )),
          SizedBox(
            width: double.infinity,
            child: MaterialButton(
                color: Colors.red,
                onPressed: () {
                },
                child: TextButton(
                  onPressed: () {
                    MyInfoDialog.showEnsure(context, () {
                      RouteController.loginPage(context);
                      context.read<UserStateStore>().logout();
                    });
                  },
                  child: const Text("注销",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      )),
                )),
          ),
        ],
      ),
    );
  }
}
