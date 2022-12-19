import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

/// 范围内的int 数值
int getRandomInt(int limit){
  return Random().nextInt(limit);
}

/// 获得随机字符串
String generateRandomString(int length) {
  final _random = Random();
  const _availableChars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final randomString = List.generate(length,
          (index) => _availableChars[_random.nextInt(_availableChars.length)])
      .join();

  return randomString;
}

 /// 延时任务
 Future<T> timeOut<T>(T Function() fn, {Duration t=const Duration(seconds: 1)}) async {
  await Future.delayed(t);
  return fn();
}