import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Provider/Stores/userState.dart';
import '../PhotoViewPage/imgDataHandler.dart';

class MyFavImgPage extends StatefulWidget {
  MyFavImgPage({super.key, required this.fn});

  late Function(ApiImageData d)? fn;

  @override
  _MyFavImgPageState createState() => _MyFavImgPageState();
}

class _MyFavImgPageState extends State<MyFavImgPage> {
  late List<ApiImageData> favList;


  @override
  Widget build(BuildContext context) {
    favList = context.select((UserStateStore user) => user.favImgList);
    int itemCount = favList.length;
    return Container(
        color: Colors.black,
        child:ListView.separated(
      padding: const EdgeInsets.all(5.0),
      itemBuilder: favItemCard,
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: 12.0,
      ),
      itemCount: itemCount,
    ));
  }

  Widget favItemCard(BuildContext context, int index) {
    return Card(
        child: Column(
      children: [
        Container(
          color: Color.fromARGB(146, 172, 209, index % 2 == 0 ? 120 : 250),
          // width: double.infinity,
          child: Column(children: [
            ListTile(
              dense: false,
              leading: Image.network(
                favList[index].site["icon"],
                fit: BoxFit.fill,
              ),
              title: Text(favList[index].site["name"] != ""
                  ? favList[index].site["name"]
                  : "无名"),
              subtitle: Text(favList[index].site["description"] != ""
                  ? favList[index].site["description"]
                  : "这个家伙很懒没有留下什么……"),
              trailing: IconButton(
                onPressed: () {
                  widget.fn!(favList[index]);
                },
                icon: Icon(Icons.double_arrow_outlined),
              ),
            ),
            Divider(height: 3.0,indent: 12, endIndent: 12, color: Colors.black87,),
            Padding(
                padding: EdgeInsets.fromLTRB(10.0, 2.0, 5.0, 2.0),
                child: Row(
                  children: [
                    Text(favList[index].title == ""
                        ? "「无名作品」"
                        : "「${favList[index].title}」", style: TextStyle(color: Colors.orange),),
                    SizedBox(width: 5.0,),
                    Expanded(child:Text(favList[index].excerpt == "" ? "空" : favList[index].excerpt, maxLines: 1, overflow: TextOverflow.ellipsis,),)
                  ],
                ))
          ]),
        ),
        Container(
          // height: 250,
          width: double.infinity,
          child: Image.network(
            favList[index].imagesUrl.length > 0
                ? favList[index].imagesUrl[0]
                : "",
            fit: BoxFit.fill,
            colorBlendMode: BlendMode.dstIn,
            repeat: ImageRepeat.noRepeat,
          ),
        ),
      ],
    ));
  }
}
