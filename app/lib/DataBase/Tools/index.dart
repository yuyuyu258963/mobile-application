import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';
import 'dart:convert' as convert;
import '../utils.dart';

// 常用的工具函数
class DBTools {
  static Future<String> getPath(String dbName) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String path = join(appDocDir.path, DBconfig.fileDir, dbName);
    return path;
  }

}

