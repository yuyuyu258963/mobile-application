import 'dart:io';
import 'dart:async';
import 'package:app/DataBase/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';
import 'dart:convert' as convert;

import 'index.dart';


/// 我的数据库基础类
class MyDb {
  String dbName = DBconfig.dbName;
  Database? database ;

  MyDb({this.database});

  // 初始化这个数据库
  Future<Database?> initDatabase() async {
    var path = await DBTools.getPath(dbName);
    database = await openDatabase(path);
    return database;
  }

  ///判断表是否存在
  Future<bool> isTableExits(String tableName) async {
    if (database == null) {
      await initDatabase();
    }
    //内建表sqlite_master
    var sql =
        "SELECT * FROM sqlite_master WHERE TYPE = 'table' AND NAME = '$tableName'";
    var res = await database?.rawQuery(sql);
    var returnRes = res != null && res.length > 0;
    return returnRes;
  }

  /// 创建数据库
  Future<String> createNewDB(String dbName) async {
    String path = await DBTools.getPath(dbName);
    var file = await File(path);

    ///判断是否存在
    if (await file.existsSync()) {
      ///如果存在就删除掉,这里只是临时这样处理,实际要根据业务需求.
      // await deleteDatabase(path);
      debugPrint('DB已经存在');
    } else {
      debugPrint('DB不存在');
      try {
        await file.create(recursive: true);
        debugPrint('DB创建成功 $path');
      } catch (error) {
        ///这里如果创建时失败要添加日志
        debugPrint('DB创建失败');
      }
    }
    return path;
  }

}