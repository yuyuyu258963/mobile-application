

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<weatherData?> queryWeather() async {
  final url = Uri.parse("https://www.tianqiapi.com/free/day?appid=23035354&appsecret=8YvlPNrz");
  final res = await http.get(url);
  if (res.statusCode != 200) {
    debugPrint(res.statusCode.toString());
    return null;
  }
  Map<String, dynamic> data = await jsonDecode(res.body);
  weatherData d = weatherData.fromMap(data);
  debugPrint(d.toString());
  return d;
}

/// 天气数据
class weatherData{
  late String week, city, wea, win, win_speed, win_meter, humidity;

  weatherData({
    required this.week,
    required this.city,
    required this.wea,
    required this.win,
    required this.win_speed,
    required this.win_meter,
    required this.humidity,
  });

  Map<String, dynamic> toMap() {
    return {
      'week': this.week,
      'city': this.city,
      'wea': this.wea,
      'win': this.win,
      'win_speed': this.win_speed,
      'win_meter': this.win_meter,
      'humidity': this.humidity,
    };
  }

  factory weatherData.fromMap(Map<String, dynamic> map) {
    return weatherData(
      week: map['week'] as String,
      city: map['city'] as String,
      wea: map['wea'] as String,
      win: map['win'] as String,
      win_speed: map['win_speed'] as String,
      win_meter: map['win_meter'] as String,
      humidity: map['humidity'] as String,
    );
  }

  @override
  String toString() {
    return 'weatherData{week: $week, city: $city, wea: $wea, win: $win, win_speed: $win_speed, win_meter: $win_meter, humidity: $humidity}';
  }
}