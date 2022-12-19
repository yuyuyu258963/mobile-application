import 'package:flutter/material.dart';

import '../../../Common/MyNotification/index.dart';
import '../../../Common/MyNotification/widgets/history_today.dart';
import '../../../Http/api/weather_api.dart';
import 'menue_config.dart';
import 'my_swiper_player.dart';

class Content_menue_page extends StatefulWidget {
  Content_menue_page({super.key, required this.changeViewPage});

  late void Function(int v,[bool slider]) changeViewPage;

  @override
  State<Content_menue_page> createState() => _Content_menue_pageState();
}

class _Content_menue_pageState extends State<Content_menue_page> {
  weatherData weatherInfo = weatherData(
      week: "星期一",
      city: '杭州',
      wea: "晴",
      win: "西北风",
      win_speed: "2级",
      win_meter: "8km/h",
      humidity: "58%");

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    queryWeather().then((value) => {
      weatherInfo = value!
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        width: double.infinity,
        child:ListView(
          children: [
            const MySwiperPlayer(),
            buildWeatherLine(),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Container(
                width: double.infinity,
                color: Color.fromARGB(187, 57, 159, 222),
                height: 400,
                child: GridView.count(
                  padding: EdgeInsets.all(10.0),
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 10.0,
                  crossAxisCount: 2,
                  // 设置长宽比  在使用GridView组件的时候子组件的Container width和height失效
                  childAspectRatio: 1,
                  children: infoCardDataList(context),
                ),
              ),
            ),
          ],
        ));
  }

  /// 绘制中间部分的天气
  Widget buildWeatherLine() {
    return Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
            height: 60,
            padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0 , 0.0),
            decoration:  const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.elliptical(8.0, 8.0)),
              color: Color.fromARGB(199, 64, 196, 255),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.account_balance_outlined, color: Color.fromARGB(
                        230, 255, 211, 174),),
                    Text(weatherInfo.city, style: TextStyle(color: Colors.white),),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.calendar_month, color: Colors.white,),
                    Text(weatherInfo.week, style: TextStyle(color: Colors.white),),
                  ],
                ),
                Row(
                  children: [
                    Icon(weatherInfo.wea == "雨" ? Icons.water_drop_rounded : Icons.wb_sunny_rounded, color: Colors.yellow,),
                    Text(weatherInfo.wea, style: TextStyle(color: Colors.white),),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.wind_power, color: Color.fromARGB(
                        255, 255, 142, 100),),
                    Text(weatherInfo.win, style: TextStyle(color: Color.fromARGB(
                        255, 255, 142, 100)),),
                    Text(weatherInfo.win_speed, style: TextStyle(color: Colors.white),),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.water_drop_sharp, color: Color.fromARGB(
                        181, 16, 72, 227), ),
                    Text(weatherInfo.humidity),
                  ],
                )
              ],
            )));
  }

  /// 下部卡片数据获取
  List<Widget> infoCardDataList(BuildContext context) {
    List<Widget> data = [];
    List<MenueItem> listSourceData = menueData();
    for(int i=0;i<menueData().length; i++){
      MenueItem element = listSourceData[i];
      data.add(
        GestureDetector(
          onTap: (){

            if (i == 0) {
              widget.changeViewPage(1, true);
            } else if (i == 1) {
              MyInfoDialog.showHistodyInfo(context);
            } else if (i == 2) {
              widget.changeViewPage(3, true);
            } else if (i == 3){
              widget.changeViewPage(2, true);
            } else {
              MyInfoDialog.errorToast("开发中  敬请期待……");
            }
          },
          child:Card(
            color: element.color,
            child: Column(
              children: [
                Expanded(
                    flex: 3,
                    child:
                    Align(alignment: Alignment.center, child: element.icon)),
                Expanded(
                    flex: 1,
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          element.content,
                          textAlign: TextAlign.center,
                        )))
              ],
            ),
          ),
        ),
      );
    }
    return data;
  }

}
