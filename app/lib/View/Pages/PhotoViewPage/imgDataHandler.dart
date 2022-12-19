import 'dart:convert';

import 'package:flutter/cupertino.dart';

/// 从 api 接口中获得的数据转化后的类型
class ApiImageData {
  late String excerpt, post_id, title, url,
      author_id, favorites, comments,
      passed_time, views, shares, image_count;
  late Map<String, dynamic> site;
  late List<String> imagesUrl;



  Map<String, dynamic> toMap() {
    return {
      'excerpt': excerpt,
      'post_id': post_id,
      'title': title,
      'url': url,
      'author_id': author_id,
      'favorites': favorites,
      'comments': comments,
      'passed_time': passed_time,
      'views': views,
      'shares': shares,
      'imagesUrl': imagesUrl,
      'image_count': image_count,
      'site': site,
    };
  }

  factory ApiImageData.fromMap(Map map) {
    return ApiImageData(
      excerpt: map['excerpt'] as String,
      post_id: map['post_id'].toString(),
      title: map['title'] as String,
      url: map['url'] as String,
      author_id: map['author_id'] as String,
      favorites: map['favorites'].toString(),
      comments: map['comments'].toString(),
      passed_time: map['passed_time'] as String,
      views: map['views'].toString(),
      shares: map['shares'].toString(),
      imagesUrl: map['imagesUrl'].cast<String>(),
      image_count: map['image_count'].toString(),
      site: map['site'],
    );
  }

  @override
  String toString() {
    return '{"excerpt": $excerpt, "post_id": $post_id, "title": $title, "url": $url, "author_id": $author_id, "favorites": $favorites, "comments": $comments, "passed_time": $passed_time, "views": $views, "shares": $shares, "imagesUrl": ${jsonEncode(imagesUrl)}, "image_count": $image_count, "site": ${jsonEncode(site)}}';
  }



  ApiImageData({
    required this.excerpt,
    required this.post_id,
    required this.title,
    required this.url,
    required this.author_id,
    required this.favorites,
    required this.comments,
    required this.passed_time,
    required this.views,
    required this.shares,
    required this.imagesUrl,
    required this.image_count,
    required this.site,
  });
}

List<ApiImageData> transImageApiData(dynamic map) {
  List feedList = map["feedList"];
  List<ApiImageData> data = [];
  feedList.forEach((element) {
    List<String> imagesUrl = [] ;
    (element["images"] as List<dynamic> ).forEach((item) {
      imagesUrl.add("https://photo.tuchong.com/${item["user_id"]}/m/${item["img_id_str"]}.webp");
    });
    element["imagesUrl"] = imagesUrl;
    data.add(ApiImageData.fromMap(element));
  });
  debugPrint("images Number :: ${data.length.toString()}");
  return data;
}
