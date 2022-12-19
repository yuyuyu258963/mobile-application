import 'package:flutter/cupertino.dart';

import '../../Http/api/pic_api.dart';
import '../../Users/Utils/FuncTools/index.dart';
import '../../View/Pages/PhotoViewPage/imgDataHandler.dart';

/// 全局数据统一管理部分
class DataStore with ChangeNotifier {
  List<ApiImageData> imagesList = [];

  /// 初始化图片数据
  void initData() async {
    imagesList = (await queryFavPic())!;
  }

  /// 从中获得一个随机的推荐
  ApiImageData? getRandomItemData({bool push=false}){
    if (push) {
      initData();
    }
    if (imagesList.isEmpty ) {
      return null;
    }
    int idx = getRandomInt(imagesList.length);
    return imagesList[idx];
  }

}