import 'package:app/DataBase/Tools/MyDataBase.dart';
import 'package:flutter/cupertino.dart';

import '../../interface/userInfo.dart';

/// 数据库表
class UserData extends MyDb {
  String TableName = "userInfo";
  UserData() {
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
  email Text Primary key  NOT NULL,
  phoneNumber INTEGER not null,
  userName Text not null,
  password Text not null
  )
  ''');
      batch?.commit();
    }
  }


  // 插入用户数据
  Future<bool?> insertUsr(MyUserInfo user) async {
    if (database == null) {
      await initDatabase();
    }

    var userIn = await checkUserIn(user.email);
    debugPrint(userIn.toString());
    if (userIn != null && !userIn) {
      int? id2 = await database?.rawInsert(
          'INSERT INTO userInfo(email, phoneNumber, userName, password) VALUES(?, ?, ?, ?)',
          [user.email, user.phoneNumber, user.userName, user.password]);
      debugPrint(":::::::::  ${(id2).toString()}");
      return (id2 ?? 0) > 0;
    }
    return false;
  }

  /// 查看用户是否已经注册
  Future<bool?> checkUserIn(String email) async{
    var arr = await findUser(email);
    return arr?.isNotEmpty;
  }

  /// 用email查找指定的用户信息
  Future<List<Map<String, dynamic>>?> findUser(String email) async {
    if (database == null) {
      await initDatabase();
    }
    List<Map<String, dynamic>> list = await database?.rawQuery("select * from userInfo where email=?",[email]) as List<Map<String, dynamic>>;
    debugPrint(list.toString());
    return list;
  }

  /// 更新库中的字段
  ///
  /// return bool 更新字段是否成功
  Future<bool> update(String email, idName, Map<String, Object?> val) async {
    if (database == null) {
      await initDatabase();
    }
    int? count = await database?.update(TableName, val, where: '$idName = ?', whereArgs: [email]);
    debugPrint(count.toString());
    bool result = (count ?? 0) > 0;
    return result;
  }


}
