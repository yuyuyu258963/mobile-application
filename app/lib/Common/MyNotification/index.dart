import 'package:app/Common/MyNotification/widgets/history_today.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Http/api/history_storyTody.dart';
import '../../Users/Utils/userInfo/infoShow.dart';

/// 用于展示跳出的各种提示框
class MyInfoDialog {
  MyInfoDialog();

  // 跳出确认
  static showEnsure(context, Function() okFn, [dynamic cancelFn]) async {
    cancelFn ??= () {
      Navigator.pop(context);
    };

    Widget okButton = MaterialButton(
      color: Colors.redAccent,
      onPressed: okFn,
      child: const Text(
        "确定",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
      ),
    );
    Widget cancelButton = MaterialButton(
      color: Colors.green,
      onPressed: cancelFn,
      child: Text(
        "取消",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
      ),
    );

    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("注意"),
            content: const Text("您确定要注销吗?"),
            actions: [
              cancelButton,
              okButton,
            ],
          );
        });
  }

  /// to show author info by notification
  static showAuthorInfo(context) async {
    var res = await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text(
            "作者信息",
            textAlign: TextAlign.center,
          ),
          children: authorDetail,
        );
      },
    );
    debugPrint(res);
  }

  /// 跳出框展示验证码
  static showCaptcha(context, String msg) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("验证码"),
            content: Text(msg),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("确定"),
              ),
            ],
          );
        });
  }

  /// to contribute money to author
  static showContributeMoney(context, [String title = "资助"]) async {
    var res = await showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text(
              title,
              textAlign: TextAlign.center,
            ),
            children: <Widget>[
              SizedBox(
                width: 200,
                height: 350,
                child: Image.asset(
                  "images/mm_facetoface_collect_qrcode_1670319212855.png",
                  fit: BoxFit.fill,
                ),
              )
            ],
          );
        });
    debugPrint(res);
  }

  /**
   * 展示历史上今天的数据
   */
  static showHistodyInfo(context) async {
    late List<hitoryDataHandler> hisTodayData;
    hisTodayData = (await queryFavPic())!;

    var res = await showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text(
              "历史上的今天",
              textAlign: TextAlign.center,
            ),
            children: [
              Container(
                height: 500,
                width: 200,
                child: ListView.builder(
                    itemCount: hisTodayData?.length,
                    itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(hisTodayData[index].title),
                    subtitle: Text(hisTodayData[index].details),
                  );
                }),
              ),
            ],
          );
        });
  }

  /// 在底部显示信息
  static showBottomMessage(BuildContext context, String title) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(title),
          action: SnackBarAction(
            label: '取消',
            onPressed: () {},
          )),
    );
  }

  // 使用短暂的提示信息框
  static showToast(String? msg) {
    Fluttertoast.showToast(msg: msg!, backgroundColor: Colors.red);
  }

  // 成功的提示
  static okToast(String text) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 16,
    );
  }

  static errorToast(String text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  // 功能等待去开发
  static waitingToExploitation() {
    Fluttertoast.showToast(
        msg: "模块开发中...",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER_LEFT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        webPosition: "right",
        fontSize: 16.0);
  }
}
