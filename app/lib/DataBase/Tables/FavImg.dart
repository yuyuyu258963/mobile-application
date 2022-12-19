import 'dart:convert';

import 'package:app/DataBase/Tables/userData.dart';
import 'package:flutter/cupertino.dart';

import '../../View/Pages/PhotoViewPage/imgDataHandler.dart';
import '../../interface/userInfo.dart';
import '../Tools/MyDataBase.dart';

class FavImageList extends MyDb {
  String TableName = "favImageList";

  FavImageList() {
    if (database == null) {
      initDatabase();
    }
  }

  /// 创建用户信息表
  createTable(String tableName) async {
    if (database == null) {
      initDatabase();
    }
    bool isTableExit = await isTableExits(TableName);
    if (!isTableExit) {
      var batch = database?.batch();
      batch?.execute('''
  CREATE TABLE $tableName (
  email Text NOT NULL,
  post_id Text not null,
  imgData Text not null,
  primary key (email, post_id) 
  )
  ''');
      batch?.commit();
    }
  }

  // 插入数据
  Future<bool?> insertFavImgData(MyUserInfo user, ApiImageData imgData) async {
    if (database == null) {
      await initDatabase();
    }

    var userIn = await UserData().checkUserIn(user.email);
    debugPrint(userIn.toString());
    if (userIn != null && userIn) {
      debugPrint("是否成功");
      int? id2 = await database?.rawInsert(
          'INSERT INTO $TableName(email, post_id, imgData) VALUES(?, ?, ?)',
          [user.email, imgData.post_id, jsonEncode(imgData.toMap())]);
      debugPrint(":::::::::  ${(id2).toString()}");
      debugPrint(jsonEncode(imgData.toMap()));
      return (id2 ?? 0) > 0;
    }
    return false;
  }

  /// 更新库中的字段
  ///
  /// return bool 更新字段是否成功
  Future<bool> delete(String email, post_id) async {
    if (database == null) {
      await initDatabase();
    }
    int? count = await database
        ?.delete(TableName, where: 'email = ? and post_id = ?', whereArgs: [email, post_id]);
    debugPrint(count.toString());
    bool result = (count ?? 0) > 0;
    return result;
  }

  /// 查找某人最喜欢的图
  Future<List<ApiImageData>?> queryImage(MyUserInfo user) async {
    if (database == null) {
      await initDatabase();
    }
    List<ApiImageData> favList = [];
    List data = await (database?.rawQuery("""
      select * from ${TableName} where email=?
    """,[user.email])) as List;
    data.forEach((element) {
      debugPrint(element["imgData"]);
      dynamic itemData = jsonDecode(element["imgData"]);
      ApiImageData item = ApiImageData.fromMap(itemData);
      favList.add(item);
    });
    return favList;
  }

}
