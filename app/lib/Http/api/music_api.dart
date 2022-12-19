
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

/// 网易云随机音乐接口
Future<musicDataHandler?> queryMusicByRandom() async {
  final url = Uri.parse("https://api.uomg.com/api/rand.music?format=json");
  final res = await http.get(url);
  if (res.statusCode != 200) {
    return null;
  } else {
    debugPrint(res.statusCode.toString());
  }
  Map<String, dynamic> data = await jsonDecode(res.body)["data"];
  debugPrint(data.toString());
  musicDataHandler d = musicDataHandler.fromMap(data);
  debugPrint(d.toString());
  return d;
}

/// 音乐数据示例
class musicDataHandler {
  late String name, url, thumbnail, artistsname;

  musicDataHandler({
    required this.name,
    required this.url,
    required this.thumbnail,
    required this.artistsname,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'url': this.url,
      'thumbnail': this.thumbnail,
      'artistsname': this.artistsname,
    };
  }

  factory musicDataHandler.fromMap(Map<String, dynamic> map) {
    return musicDataHandler(
      name: map['name'] as String,
      url: map['url'] as String,
      thumbnail: map['picurl'] as String,
      artistsname: map['artistsname'] as String,
    );
  }

  @override
  String toString() {
    return 'musicDataHandler{name: $name, url: $url, thumbnail: $thumbnail, artistsname: $artistsname}';
  }
}