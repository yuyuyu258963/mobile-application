import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../View/Pages/PhotoViewPage/imgDataHandler.dart';

Future<List<ApiImageData>?> queryFavPic() async {
  final url = Uri.parse("https://api.tuchong.com/feed-app");
  final res = await http.get(url);
  if (res.statusCode != 200) {
    debugPrint(res.statusCode.toString());
    return null;
  }
  Map data = await jsonDecode(res.body);
  debugPrint(data["feedList"][0]["site"].toString());
  return transImageApiData(data);
}