import 'package:flutter/material.dart';

import '../../Routes/RouteController.dart';

/// @{title} String the content to show on the screen
/// 展示未登录界面
class NotFoundPage extends StatefulWidget {
  const NotFoundPage({super.key, required this.title});

  final String title;

  @override
  State<NotFoundPage> createState() => _NotFoundPageState();
}

class _NotFoundPageState extends State<NotFoundPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        leading: IconButton(
            onPressed: () {
              RouteController.goBackPage(context);
            },
            icon: const Icon(Icons.keyboard_return)),
      ),
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Text(widget.title),
      ),
    );
  }
}
