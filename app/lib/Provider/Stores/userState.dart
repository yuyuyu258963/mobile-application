
import 'package:flutter/cupertino.dart';

import '../../DataBase/Tables/FavImg.dart';
import '../../View/Pages/PhotoViewPage/imgDataHandler.dart';
import '../../interface/userInfo.dart';

// 用户登录状态
class UserStateStore with ChangeNotifier{
  bool loginState = false;
  List<ApiImageData> favImgList = [];
  MyUserInfo? user;

  @override
  String toString() {
    return 'UserState{loginState: $loginState, user: ${user.toString()}}';
  } // 用户成功登录
  void login(MyUserInfo u) async {
    user = u;
    loginState = true;
    await initFavList();
    debugPrint("login success");
  }

  // 用户退出登录
  void logout(){
    loginState = false;
  }

  /// 初始化fav列表
  initFavList() async {
    debugPrint("initFavList");
    List<ApiImageData> data = (await FavImageList().queryImage(user!))!;
    favImgList = data;
  }

  /// 设置喜欢列表
  void setFavImgList(List<ApiImageData> f){
    favImgList = f;
  }
}
