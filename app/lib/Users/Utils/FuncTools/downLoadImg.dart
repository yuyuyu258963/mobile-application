import 'dart:typed_data';

import 'package:app/Common/MyNotification/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:dio/dio.dart';


String _imagePath =
    "https://www.callmysoft.com/static/index/images/image_dgital%20creativity.png";

/// 保存图片到本地相册
void saveImg(BuildContext context,String imgPath) async {
  debugPrint("saveImg $imgPath");
  bool req = await Permission.storage.request().isGranted;
  if (await Permission.storage.request().isGranted) {
    var response = await Dio()
        .get(imgPath, options: Options(responseType: ResponseType.bytes));
    final result =
    await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    // print(result);
    if (result["isSuccess"]) {
      MyInfoDialog.errorToast("保存成功");
    } else {
      MyInfoDialog.errorToast("保存失败");
    }
  }
}
