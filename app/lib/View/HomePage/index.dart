import 'package:flutter/material.dart';

import '../../Common/MyNotification/index.dart';
import '../../Provider/Stores/MainStore.dart';
import '../../Provider/Stores/userState.dart';
import '../../Routes/RouteController.dart';
import '../Pages/MenuePage/contentMenue_page.dart';
import '../Pages/MusicPlaer/my_music_player.dart';
import '../Pages/MyFavImagePage/my_fav_img_page.dart';
import '../Pages/PhotoViewPage/imgDataHandler.dart';
import '../Pages/PhotoViewPage/my_photo_grid_view.dart';
import 'Common/MyDrawer/MyDrawer.dart';

import 'package:provider/provider.dart';

import 'Common/MybottomBar.dart';

class MyHomeBody extends StatefulWidget {
  const MyHomeBody({super.key});

  @override
  State<MyHomeBody> createState() => _MyHomeBodyState();
}

class _MyHomeBodyState extends State<MyHomeBody> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0 ;
  ApiImageData? imgListData;

  /// 查看点赞图集的时候动作
  void viewFavImg(ApiImageData d){
    imgListData = d;
    /// 因为外部用了 滑动的页面 所以要设置两个页面的间隔
    int pageDomain = 2;
    changePageIndex(1, true);
    /// 渲染完毕后 重新把 imgListData 设置为 null, 避免总是出现一样的内容
    WidgetsBinding.instance.addPostFrameCallback((mag) {
      pageDomain--;
      if (pageDomain==0) {
        imgListData = null;
      }
      debugPrint("  页面渲染完毕  ");
    });
  }

  List<Widget> getPageData(){
    return [
      Content_menue_page(changeViewPage: changePageIndex ),
      MyPhotoGridView(imageListDataSet: imgListData),
      MyMusicPlayer(),
      MyFavImgPage(fn: viewFavImg),
    ];
  }

  /// 验证用户登录状态避免非法登录
  void checkLogin(BuildContext context){
    final loginState = context.select((UserStateStore u) => u.loginState);
    if (!loginState) {
      MyInfoDialog.errorToast("您还未登录！");
      // 跳转回到登录页面
      RouteController.loginPage(context);
    }
  }

  /// 跳转页面内容
  void changePageIndex(int v, [bool slider=false]){
    setState(() {
      _currentPageIndex = v;
      if (slider) {
        _pageController.animateToPage(v, duration: const Duration(milliseconds: 400), curve: Curves.easeInOutQuart);
      }  
    });
  }
  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    checkLogin(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 142, 100),
        title: const Text('小工具'),
        actions: <Widget>[
          IconButton(
              onPressed: () {},
              tooltip: "share",
              icon: const Icon(Icons.share)),
          PopupMenuButton(
            itemBuilder: (context) => <PopupMenuItem<String>>[
              PopupMenuItem<String>(
                value: "content",
                child: TextButton(
                  onPressed: () {
                    MyInfoDialog.showAuthorInfo(context);
                  },
                  child: const Text("content with us"),
                ),
              ),
              PopupMenuItem<String>(
                value: "money",
                child: TextButton(
                  onPressed: () {
                    MyInfoDialog.showContributeMoney(context);
                  },
                  child: const Text("contribute money"),
                ),
              )
            ],
          )
        ],
      ),
      drawer: const MyDrawer(),
      // backgroundColor: Colors.lightGreen,
      body: MyPageView(context),
      bottomNavigationBar: NavigationBar(
        destinations: navigationList,
        selectedIndex: _currentPageIndex,
        onDestinationSelected: (int index) => changePageIndex(index, true),
        backgroundColor: Color(0xD84A569D),
        surfaceTintColor: Colors.red,
      ),
    );
  }

  Widget MyPageView(BuildContext context) {
    return PageView(
      physics: const ClampingScrollPhysics(),
      // 也可以选择BouncingScrollPhysics，如果你希望到达边界还能滚动回弹的话
      controller: _pageController,
      onPageChanged: changePageIndex,
      children: getPageData(),
    );
  }

}

