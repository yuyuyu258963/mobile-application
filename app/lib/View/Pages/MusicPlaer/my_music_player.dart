import 'dart:ui';

import 'package:app/Common/MyNotification/index.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import '../../../Http/api/music_api.dart';
import 'MyMp3Player.dart';
import 'Widgets/controller_bar.dart';
import 'Widgets/my_slider.dart';
import 'Widgets/rota_img.dart';
import 'package:audio_wave/audio_wave.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

class MyMusicPlayer extends StatefulWidget {
  const MyMusicPlayer({super.key});

  @override
  _MyMusicPlayerState createState() => _MyMusicPlayerState();
}

class _MyMusicPlayerState extends State<MyMusicPlayer> {
  late musicDataHandler musicInfo = musicDataHandler(
      name: "深海回响",
      url: "http://music.163.com/song/media/outer/url?id=1907978608",
      thumbnail:
          "http://p3.music.126.net/6Yj3x8y32ELWP0lw9yObtA==/109951166870616590.jpg",
      artistsname: "李尧音");

  bool isPause = false;

  /// 暂停控制
  void changePause() {
    isPause ? myMp3Player.play() : myMp3Player.pause();
    setState(() {
      isPause = !isPause;
      debugPrint("重新渲染");
    });
  }

  /// 获得随机音乐数据
  void getRandomMusic() {
    queryMusicByRandom().then((value) {
      if (value != null) {
        setState(() {
          musicInfo = value;
          myMp3Player.setUrl(musicInfo.url);
        });
      } else {
        MyInfoDialog.errorToast("请求音乐数据失败");
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRandomMusic();
    WidgetsBinding.instance.addPostFrameCallback((mag) {
      // debugPrint("加载完成");
      myMp3Player.run(musicInfo.url);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myMp3Player.dispose();
    // myMp3Player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StreamBuilder<DurationState> _progressBar() {
      return StreamBuilder<DurationState>(
        stream: myMp3Player.durationState,
        builder: (context, snapshot) {
          final durationState = snapshot.data;
          final progress = durationState?.progress ?? Duration.zero;
          final buffered = durationState?.buffered ?? Duration.zero;
          final total = durationState?.total ?? Duration.zero;
          return ProgressBar(
            progress: progress,
            total: total,
            buffered: buffered,
            onSeek: (Duration d){
              myMp3Player.seekTo(position:d);
            },
            onDragUpdate: (details) {
              debugPrint('${details.timeStamp}, ${details.localPosition}');
            },
          );
        },
      );
    }

    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color(0xFFFF8E64),
            Color(0xFF4A569D),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: Center(
            child: Column(
          children: [
            Expanded(child: Container()),
            Container(
              height: 400,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Color.fromARGB(60, 57, 159, 222),
              ),
              child: Column(
                children: [
                  Container(
                    height: 25,
                    child: Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                            onTap: () {
                              getRandomMusic();
                            },
                            child: Icon(Icons.refresh))),
                  ),
                  Expanded(
                    child: Stack(children: [
                      RotaImg(
                        thumbnail: musicInfo.thumbnail,
                        playState: isPause,
                      ),
                      ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaY: 50,
                            sigmaX: 50,
                          ),
                        ),
                      ),
                    ]),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 10)),
                  Container(
                    height: 50,
                    child: Column(
                      children: [
                        Text(musicInfo.name,
                            maxLines: 1, style: TextStyle(fontSize: 20)),
                        Text(
                          musicInfo.artistsname,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    // child: MySlider(),
                    child: _progressBar(),
                  ),
                  ControllerBar(
                    key: UniqueKey(),
                    isPause: isPause,
                    ppHandler: changePause,
                    getRandomMusic: getRandomMusic,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              height: 100,
              width: 300,
              margin: EdgeInsets.only(top: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Center(
                  child: AudioWave(
                height: 90,
                width: 200,
                spacing: 3,
                bars: [
                  AudioWaveBar(
                      heightFactor: 0.01 * 10, color: Colors.lightBlueAccent),
                  AudioWaveBar(heightFactor: 0.01 * 30, color: Colors.blue),
                  AudioWaveBar(heightFactor: 0.01 * 70, color: Colors.black),
                  AudioWaveBar(heightFactor: 0.01 * 40),
                  AudioWaveBar(heightFactor: 0.01 * 100, color: Colors.orange),
                  AudioWaveBar(
                      heightFactor: 0.01 * 90, color: Colors.lightBlueAccent),
                  AudioWaveBar(heightFactor: 0.01 * 80, color: Colors.blue),
                  AudioWaveBar(heightFactor: 0.01 * 70, color: Colors.black),
                  AudioWaveBar(heightFactor: 0.01 * 40),
                  AudioWaveBar(heightFactor: 0.01 * 20, color: Colors.orange),
                  AudioWaveBar(
                      heightFactor: 0.01 * 10, color: Colors.lightBlueAccent),
                  AudioWaveBar(heightFactor: 0.01 * 30, color: Colors.blue),
                  AudioWaveBar(heightFactor: 0.01 * 70, color: Colors.black),
                  AudioWaveBar(heightFactor: 0.01 * 40),
                  AudioWaveBar(heightFactor: 0.01 * 20, color: Colors.orange),
                  AudioWaveBar(
                      heightFactor: 0.01 * 10, color: Colors.lightBlueAccent),
                  AudioWaveBar(heightFactor: 0.01 * 30, color: Colors.blue),
                  AudioWaveBar(heightFactor: 0.01 * 70, color: Colors.black),
                  AudioWaveBar(heightFactor: 0.01 * 40),
                  AudioWaveBar(heightFactor: 0.01 * 20, color: Colors.orange),
                  AudioWaveBar(heightFactor: 0.01 * 70, color: Colors.black),
                  AudioWaveBar(
                      heightFactor: 0.01 * 10, color: Colors.lightBlueAccent),
                ],
              )),
            ),
            Expanded(child: Container()),
          ],
        )));
  }
}
