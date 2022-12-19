import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';


class MySwiperPlayer extends StatefulWidget {
  const MySwiperPlayer({super.key});

  @override
  _MySwiperPlayerState createState() => _MySwiperPlayerState();
}

class _MySwiperPlayerState extends State<MySwiperPlayer> {
  List<String> imgList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(int i=1;i<=4;i++){
      imgList.add("images/swiper/swiper_$i.jpg");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      child: Swiper(
        autoplay: true,
        itemBuilder: (BuildContext context,int index){
          return Stack(
            children: <Widget>[
              Container(
                // margin: EdgeInsets.all(0),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(offset: Offset(1, 1), color: Colors.black12, spreadRadius: 3.0, blurRadius: 7.0),
                      BoxShadow(offset: Offset(-1, -1), color: Colors.black12, spreadRadius: 3.0, blurRadius: 7.0),
                      BoxShadow(offset: Offset(-1, 1), color: Colors.black12, spreadRadius: 3.0, blurRadius: 7.0),
                      BoxShadow(offset: Offset(1, -1), color: Colors.black12, spreadRadius: 3.0, blurRadius: 7.0),
                    ],
                    borderRadius: BorderRadius.circular(15.0),
                    image: DecorationImage(image: AssetImage(imgList[index]),fit: BoxFit.cover)
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text('$index', style: TextStyle(color: Colors.white, fontSize: 25.0)),
              )
            ],
          );
        },
        itemCount: imgList.length,
        fade: 0.0,
        scale: 0.0,
        curve: Curves.easeInOut,
        layout: SwiperLayout.TINDER,
        duration: 600,
        autoplayDelay: 4000,
        pagination: SwiperPagination(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30)
        ),
      ),
    );
  }
}
