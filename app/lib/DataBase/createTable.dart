import 'package:flutter/cupertino.dart';

import 'Tables/FavImg.dart';
import 'Tables/userData.dart';

// 初始化创建数据库
createTable() async{
  WidgetsFlutterBinding.ensureInitialized();
  var userDbHandler = UserData();
  var favImageDbHandler = FavImageList();
  await userDbHandler.createNewDB(userDbHandler.dbName);
  await userDbHandler.createTable(userDbHandler.TableName);
  await favImageDbHandler.createTable(favImageDbHandler.TableName);
}
