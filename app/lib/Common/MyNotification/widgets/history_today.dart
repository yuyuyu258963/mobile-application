import 'package:flutter/material.dart';

import '../../../Http/api/history_storyTody.dart';
import '../../../View/Pages/PhotoViewPage/imgDataHandler.dart';

/**
 *  历史上的今天的组件
 */
class HistoryToday extends StatefulWidget {
  const HistoryToday({super.key});


  @override
  _HistoryTodayState createState() => _HistoryTodayState();
}

class _HistoryTodayState extends State<HistoryToday> {
  late List<hitoryDataHandler> hisTodayData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    queryFavPic().then((value) {
      hisTodayData = value!;
      debugPrint(hisTodayData.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
