import 'package:flutter/material.dart';
import 'App.dart';
import 'package:provider/provider.dart';

import 'DataBase/createTable.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;
  await createTable();
  debugPrint("初始化 run app");
  runApp(const MyApp());
}
