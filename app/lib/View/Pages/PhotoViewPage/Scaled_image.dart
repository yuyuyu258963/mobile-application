import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';

typedef PageChanged = void Function(int index);

class PhotoPreview extends StatefulWidget {
  late List galleryItems; //图片列表
  final int defaultImage; //默认第几张
  final PageChanged pageChanged; //切换图片回调
  late Axis direction; //图片查看方向

  PhotoPreview({
    super.key,
    required this.galleryItems,
    this.defaultImage = 1,
    required this.pageChanged,
    this.direction = Axis.horizontal,
  }) : assert(galleryItems != null);

  @override
  _PhotoPreviewState createState() => _PhotoPreviewState();
}

class _PhotoPreviewState extends State<PhotoPreview> {
  late int tempSelect;

  @override
  void initState() {
    // TODO: implement initState
    tempSelect = widget.defaultImage + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Container(
            child: buildImageList(),
          ),

          /// 顶部组件布局
          Positioned(
            left: 20,
            top: 20,
            child: Text(
              '$tempSelect/${widget.galleryItems.length}',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Positioned(
            right: 5,
            top: MediaQuery.of(context).padding.top,
            child: IconButton(
              icon: const Icon(
                Icons.close,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 获得绘制Image列表的部分
  Widget buildImageList() {
    return PhotoViewGallery.builder(
        scrollPhysics: const BouncingScrollPhysics(),
        builder: (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(widget.galleryItems[index]),
          );
        },
        scrollDirection: widget.direction,
        itemCount: widget.galleryItems.length,
        backgroundDecoration: const BoxDecoration(color: Colors.black),
        pageController: PageController(initialPage: widget.defaultImage),
        onPageChanged: (index) => setState(() {
              tempSelect = index + 1;
              if (widget.pageChanged != null) {
                widget.pageChanged(index);
              }
            }));
  }
}
