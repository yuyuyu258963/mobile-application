import 'package:flutter/material.dart';

class Demo extends StatelessWidget {
  Demo({super.key, this.title = "title"});
  late String title;


  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: (){
          debugPrint(context.toString());
        },
          child: Text(title)),
    );
  }
}
