import 'package:flutter/material.dart';

import '../MyMp3Player.dart';

class ControllerBar extends StatefulWidget {
   ControllerBar({super.key, required this.isPause, required this.ppHandler, required this.getRandomMusic });

  late bool isPause;
  late Function()? ppHandler;
  late Function()? getRandomMusic;

  @override
  _ControllerBarState createState() => _ControllerBarState();
}

class _ControllerBarState extends State<ControllerBar> {
  late bool isPause ;

  @override
  void didUpdateWidget(covariant ControllerBar oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    isPause = widget.isPause;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Container()),
        IconButton(
          onPressed: () {
            // myMp3Player.seekTo(position: Duration.zero);
            widget.getRandomMusic!();
          },
          icon: Icon(
            Icons.skip_previous,
            size: 40,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        IconButton(
          onPressed: widget.ppHandler,
          icon: Icon(isPause ? Icons.play_arrow : Icons.pause, size: 40),
        ),
        SizedBox(
          width: 10,
        ),
        IconButton(
          onPressed: () {
            myMp3Player.seekTo(position: myMp3Player.duration);
            widget.getRandomMusic!();
          },
          icon: Icon(Icons.skip_next, size: 40),
        ),
        Expanded(child: Container()),
      ],
    );
  }
}
