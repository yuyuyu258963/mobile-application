import 'package:app/DataBase/Tables/userData.dart';
import 'package:flutter/material.dart';
import '../../../Common/MyNotification/index.dart';
import '../../../DataBase/Tables/FavImg.dart';
import '../../../Http/api/pic_api.dart';
import '../../../Provider/Stores/MainStore.dart';
import  '../../../Provider/Stores/userState.dart';
import '../../../Users/Utils/FuncTools/downLoadImg.dart';
import '../../../interface/userInfo.dart';
import 'Scaled_image.dart';
import 'package:provider/provider.dart';

import 'dart:math';

import 'imgDataHandler.dart';

class MyPhotoGridView extends StatefulWidget {
  MyPhotoGridView({super.key, this.imageListDataSet});

  late ApiImageData? imageListDataSet ;
  @override
  _MyPhotoGridViewState createState() => _MyPhotoGridViewState();
}

class _MyPhotoGridViewState extends State<MyPhotoGridView> {
  late ScrollController _imageListScrollC;
  var historyImageIndex = 0;

  /// 用于避免重复刷新
  int currentImageIndex = -1;
  ApiImageData? detailData;
  bool? isPhotoFav;

  List<String> list = [
    'https://goss.cfp.cn/creative/vcg/800/new/VCG211241121526.jpg',
    "https://photo.tuchong.com/11072157/m/930033757.webp",
    'https://goss1.cfp.cn/creative/vcg/800/new/VCG41N1210205351.jpg',
    'https://goss1.cfp.cn/creative/vcg/800/new/VCG41N1210205351.jpg',
    'https://goss1.cfp.cn/creative/vcg/800/new/VCG41N1210205351.jpg',
  ];

  /// 改变滑动到的图片位置
  void changeCrrImageIndex(int value) {
    setState(() {
      currentImageIndex = value;
    });
  }

  void viewLargeImg(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => PhotoPreview(
                  galleryItems: list,
                  defaultImage: index,
                  pageChanged: (int index) {
                    debugPrint("page_$index");
                  },
                )));
  }

  /// 选择移动图片
  void slidImage(bool pre) {
    setState(() {
      if (pre) {
        currentImageIndex =
            (currentImageIndex - 1) >= 0 ? currentImageIndex - 1 : 0;
      } else {
        currentImageIndex = (currentImageIndex + 1) >= list.length
            ? list.length - 1
            : (currentImageIndex + 1);
      }
    });
  }

  /// 改变喜欢的状态
  void changeFav(bool d){
    setState(() {
      isPhotoFav = d;
    });
  }

  /// 获得图片数据
  void getInitImageDataSource([ApiImageData? imagesData]) {
    imagesData ??= context.read<DataStore>().getRandomItemData();
    detailData = imagesData;
    currentImageIndex = 0;
    historyImageIndex = -1;
    list = (detailData?.imagesUrl)!;
    debugPrint(detailData?.post_id.toString());
    // debugPrint(widget.imageListDataSet.toString());
  }


  @override
  void initState() {
    super.initState();
    getInitImageDataSource(widget.imageListDataSet);
    _imageListScrollC = ScrollController();
  }

  /// 内部控制器一起跟着销毁
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _imageListScrollC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// 查看点赞状态
    bool isFav(ApiImageData d,List<ApiImageData> favList){
      List<ApiImageData> favList = context.select((UserStateStore user) => user.favImgList);
      for (var element in favList) {
        if (element.post_id == d.post_id) {
          return true;
        }
      }
      return false;
    }
    List<ApiImageData> favList = context.watch<UserStateStore>().favImgList;
    isPhotoFav = isFav(detailData!, favList);
    return Material(
      color: Colors.black,
      child: Column(children: [
        buildLeadingHeadTool(context),
        buildSecondTextLine(),
        buildToolMiddleBar(),
        buildLargeImageContainer(context),
        buildSliderLine(),
      ]),
    );
  }

  /// 绘制第二部分的文字区域
  Widget buildSecondTextLine() {
    return Expanded(
      flex: 3,
      child: Card(
        margin: EdgeInsets.all(5.0),
        color: Colors.blueGrey,
        child: Container(
          width: double.infinity,
          child: ListView(children: [
            ListTile(
                leading: Image.network("${detailData?.site["icon"]}"),
                title: Text("${detailData?.site["name"]}"),
                subtitle: Row(
                  children: [
                    Text("${detailData?.passed_time}"),
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.remove_red_eye_rounded,
                      color: Colors.grey,
                    ),
                    Text("${detailData?.views}"),
                  ],
                ),
                trailing: ElevatedButton(
                  onPressed: () {},
                  child: Text("关注"),
                )),
            Text(
              "${detailData?.title}",
              textAlign: TextAlign.center,
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                child: Text("${detailData?.excerpt}")),
          ]),
        ),
      ),
    );
  }

  /// 获得顶部的工具行
  Widget buildLeadingHeadTool(BuildContext context) {
    MyUserInfo usr = context.read<UserStateStore>().user as MyUserInfo;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// 点赞数目
        Row(
          children: [
            IconButton(
                onPressed:  () async {
                  /// 点赞状态更新
                  if (!isPhotoFav!) {
                    FavImageList().insertFavImgData(usr, detailData!).then((value) async {
                      MyInfoDialog.errorToast("点赞成功");
                      await context.read<UserStateStore>().initFavList();
                      changeFav(!isPhotoFav!);
                    }).catchError((err) {
                      MyInfoDialog.errorToast("点赞失败");
                    });
                  }
                  else{
                    FavImageList().delete(usr.email, detailData?.post_id).then((value) async {
                      MyInfoDialog.errorToast("取消点赞");
                      await context.read<UserStateStore>().initFavList();
                      changeFav(!isPhotoFav!);
                    }).catchError((err) {
                      MyInfoDialog.errorToast("取消点赞失败");
                    });
                  }
                },
                icon: Icon(Icons.favorite, color: isPhotoFav! ? Colors.red : Colors.white)),
            Text(
              (detailData?.favorites as String),
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {}, icon: Icon(Icons.chat, color: Colors.white)),
            Text(
              (detailData?.comments as String),
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.more_vert, color: Colors.white)),
          ],
        ),
      ],
    );
  }

  /// 绘制中间部分的图片操作的按钮
  Widget buildToolMiddleBar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 15.0, 0.0),
      child: Container(
        height: 30,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      getInitImageDataSource();
                    });
                  },
                  icon: Icon(
                    Icons.refresh,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {
                    saveImg(context, (detailData?.imagesUrl[currentImageIndex])!);
                  },
                  icon: Icon(
                    Icons.file_download,
                    color: Colors.white,
                  ))
            ]),
            Text(
              '${currentImageIndex + 1}/${list.length}',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            IconButton(
                onPressed: () {
                  viewLargeImg(currentImageIndex);
                },
                icon: Icon(
                  Icons.aspect_ratio_outlined,
                  color: Colors.white,
                ))
          ],
        ),
      ),
    );
  }

  /// 绘制中间部分的大图
  Widget buildLargeImageContainer(BuildContext context) {
    return Expanded(
        flex: 5,
        child: Stack(
            alignment: Alignment.center,
            // 设置填充方式展接受父类约束最大值
            fit: StackFit.expand,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: GestureDetector(
                    onTap: () {
                      viewLargeImg(currentImageIndex);
                    },
                    child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 600),
                        // transitionBuilder: AnimatedSwitcher.(),
                        switchInCurve: Curves.linear,
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          var tween = Tween<Offset>(
                              begin: Offset(1, 0), end: Offset(0, 0));
                          return FadeTransition(
                            // position: tween.animate(animation),
                            opacity: animation,
                            child: child,
                          );
                        },
                        child: Image.network(
                          key: Key("largePic_$currentImageIndex"),
                          list[currentImageIndex],
                          fit: BoxFit.contain,
                          repeat: ImageRepeat.noRepeat,
                        ))),
              ),
              Positioned(
                  right: 5,
                  child: IconButton(
                    onPressed: () {
                      slidImage(false);
                    },
                    icon: const Icon(
                      Icons.chevron_right,
                      size: 50,
                      color: Colors.blueGrey,
                    ),
                  )),
              Positioned(
                  left: -20,
                  child: IconButton(
                    onPressed: () {
                      slidImage(true);
                    },
                    icon: const Icon(
                      Icons.chevron_left,
                      size: 50,
                      color: Colors.blueGrey,
                    ),
                  )),
            ]));
  }

  Widget buildSliderLine() {
    return Container(
      height: 150,
      padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: buildListView(context),
    );
  }

  // 绘制底部的滑动图片
  Widget buildListView(BuildContext context) {
    return ListView.separated(
      key: Key("myListViewImage"),
      controller: _imageListScrollC,
      itemCount: list.length,
      cacheExtent: 1.0,
      scrollDirection: Axis.horizontal,
      itemBuilder: itemImage,
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        width: 16.0,
      ),
    );
  }

  Widget itemImage(BuildContext context, index) {
    GlobalKey anchorKey = GlobalKey();
    var contentSize = MediaQuery.of(context).size;
    var contentCenter = Point(contentSize.width / 2, contentSize.height / 2);

    /// 监听滑动事件
    void itemTag() {
      changeCrrImageIndex(index);
      RenderBox? renderBox =
          anchorKey.currentContext?.findRenderObject() as RenderBox?;
      Rect? rect = renderBox?.paintBounds;
      Offset? vector3 = renderBox?.localToGlobal(Offset.zero);
      Point center = Point(
          (vector3?.dx as double) + (rect?.size.width! as double) / 2,
          (vector3?.dy as double) + (rect?.size.height as double) / 2);
      debugPrint(center.toString());
      var offset = _imageListScrollC.offset;
      offset += (center.x - contentCenter.x);
      if (offset < 0) {
        offset = 0;
      } else if (offset > _imageListScrollC.position.maxScrollExtent) {
        offset = _imageListScrollC.position.maxScrollExtent;
      }

      _imageListScrollC.animateTo(offset,
          duration: const Duration(
            milliseconds: 300,
          ),
          curve: Curves.bounceInOut);
    }

    // 页面渲染完毕时再执行
    WidgetsBinding.instance.addPostFrameCallback((mag) {
      if (historyImageIndex != currentImageIndex &&
          currentImageIndex == index) {
        historyImageIndex = currentImageIndex;
        itemTag();
      }
    });

    return InkWell(
      key: anchorKey,
      onTap: itemTag,
      child: Opacity(
          opacity: currentImageIndex == index ? 1 : 0.5,
          child: Container(
              decoration: BoxDecoration(
                border: currentImageIndex == index
                    ? Border(
                        left: BorderSide(
                          width: 5, //宽度
                          color: Colors.white, //边框颜色
                        ),
                        top: BorderSide(
                          width: 5, //宽度
                          color: Colors.white, //边框颜色
                        ),
                        right: BorderSide(
                          width: 5, //宽度
                          color: Colors.white, //边框颜色
                        ),
                        bottom: BorderSide(
                          width: 5, //宽度
                          color: Colors.lightBlueAccent, //边框颜色
                        ),
                      )
                    : null,
              ),
              child: Image.network(
                list[index],
                fit: BoxFit.contain,
                repeat: ImageRepeat.noRepeat,
                height: 100,
                width: 200,
                scale: 0.5,
              ))),
    );
  }
}
