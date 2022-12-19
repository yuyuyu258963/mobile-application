import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Provider/Stores/MainStore.dart';
import 'Provider/Stores/userState.dart';
import 'Routes/MonGenerateRoute.dart';
import 'Routes/index.dart';
import 'Routes/onUnknownRoute.dart';
import 'Routes/routes.dart';
import 'package:provider/provider.dart';

/// 应用程序的主入口
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        // provider 状态管理中心
        providers: [
          ChangeNotifierProvider(create: (_) => DataStore()),
          ChangeNotifierProvider(create: (_) => UserStateStore()),
        ], child: const AppBody());
  }
}

// 内容界面
class AppBody extends StatelessWidget {
  const AppBody({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<DataStore>().initData();
    // TODO: implement build
    return MaterialApp(
      title: 'Tools',

      theme: ThemeData(
        fontFamily: 'Georgia',
        highlightColor: Colors.red,
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(color: Colors.deepOrange),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          floatingLabelStyle: TextStyle(
            color: Colors.black54,
            fontSize: 16,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 3,
              color: Colors.cyan,
            ),
          ),
          border: UnderlineInputBorder(
              borderSide: BorderSide(
            width: 3,
          )),
        ),
        primarySwatch: Colors.green,
        // iconTheme: const IconThemeData(
        //   color: Colors.blue,
        //   opacity: 0.8,
        // ),
      ),
      routes: MYRoutes.routes,
      initialRoute: MYRoutes.initialRoute,
      onGenerateRoute: MYRoutes.onGenerateRoute,
      onUnknownRoute: MYRoutes.onUnknownRoute,
    );
  }
}
