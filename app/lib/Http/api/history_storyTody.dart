import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../View/Pages/PhotoViewPage/imgDataHandler.dart';

Future<List<hitoryDataHandler>?> queryFavPic() async {
  String app_id = "rgihdrm0kslojqvm";
  String app_secret = "WnhrK251TWlUUThqaVFWbG5OeGQwdz09";
  final url = Uri.parse("https://www.mxnzp.com/api/history/today?type=1&app_id=${app_id}&app_secret=${app_secret}");
  final res = await http.get(url);
  if (res.statusCode != 200) {
    debugPrint(res.statusCode.toString());
    return null;
  }
  List<Map> data = await jsonDecode(res.body)["data"].cast<Map>();
  return hitoryDataHandler.transHistoryToday(data);
}

/// 历史今天数据查看
class hitoryDataHandler{
  late String picUrl, title, year, month, day, details;

  hitoryDataHandler({
    required this.picUrl,
    required this.title,
    required this.year,
    required this.month,
    required this.day,
    required this.details,
  });

  Map<String, dynamic> toMap() {
    return {
      'picUrl': this.picUrl,
      'title': this.title,
      'year': this.year,
      'month': this.month,
      'day': this.day,
      'details': this.details,
    };
  }

  factory hitoryDataHandler.fromMap(Map map) {
    return hitoryDataHandler(
      picUrl: map['picUrl'] as String,
      title: map['title'] as String,
      year: map['year'] as String,
      month: map['month'].toString(),
      day: map['day'].toString(),
      details: map['details'] as String,
    );
  }

  static List<hitoryDataHandler> transHistoryToday(List<Map> map){
    List<hitoryDataHandler> dataList = [];
    debugPrint(map.toString());
    map.forEach((element) {
      dataList.add(hitoryDataHandler.fromMap(element));
    });
    debugPrint(dataList.length.toString());
    return dataList;

  }

  @override
  String toString() {
    return 'hitoryDataHandler{picUrl: $picUrl, title: $title, year: $year, month: $month, day: $day, details: $details}';
  }
}

