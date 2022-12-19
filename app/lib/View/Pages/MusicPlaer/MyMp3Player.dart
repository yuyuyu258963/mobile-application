import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/rxdart.dart';



class myMp3Player {
  static AudioPlayer _player = AudioPlayer();
  static List<Function> listenerpool = [];
  static Duration? duration;
  static Stream<DurationState>? durationState;

  static Future<void> initUrl(String? mpUrl) async {
    _player = AudioPlayer();
    durationState = Rx.combineLatest2<Duration, PlaybackEvent, DurationState>(
        _player.positionStream,
        _player.playbackEventStream,
            (position, playbackEvent) => DurationState(
          progress: position,
          buffered: playbackEvent.bufferedPosition,
          total: playbackEvent.duration,
        )).asBroadcastStream();
    duration = await _player.setUrl(mpUrl ?? "http://music.163.com/song/media/outer/url?id=29850683");
  }

  /// 进行音乐播放
  static Future<void> play()async {
    _player.play();
    debugPrint("paler  ${_player.duration}");
  }

  /// 设置音源
  static Future<void> setUrl(String url) async {
    await _player.setUrl(url ?? "http://music.163.com/song/media/outer/url?id=29850683");
  }

  /// 停止播放
  static Future<void> pause() async {
    _player.pause();
    debugPrint("pause");
  }

  /// 销毁播放器
  static void dispose(){
    _player.dispose();
  }

  static void Function(Duration)? seek(){
    return _player.seek;
  }


  /// 滑动效果
  static Future<void> seekTo({Duration? position}) async {
    _player.seek(position);
  }

  static Future<void> run([String? mpUrl])async {
    await initUrl(mpUrl);
    play();
  }

  /// 获得时长
  static Future<Duration?> allDuration() async {
    return _player.duration;
  }

  ///  获得时机
  static String? durationMS(){
    String strDuration = "${_player.duration}";
    debugPrint("strDuration :: ${_player.duration?.inSeconds}");

    return strDuration?.substring(3,6);
  }

  /// 音乐监听动作
  static void positionListener(fn){
    // _player.bufferedPosition. = Duration(milliseconds: 300);
    _player.durationStream.listen((event) {
      debugPrint(event.toString());
      debugPrint("oojoij");
      if(_player.playerState.playing)
        fn((event?.inSeconds)! / (_player.duration?.inSeconds)!);
    },
    );


  }
}



class DurationState {
  const DurationState({
    required this.progress,
    required this.buffered,
    this.total,
  });
  final Duration progress;
  final Duration buffered;
  final Duration? total;
}