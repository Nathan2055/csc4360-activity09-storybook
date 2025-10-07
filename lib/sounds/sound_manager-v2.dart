import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';

/*
    - sounds/dramatic-organ-a.wav
    - sounds/dramatic-organ-b.wav
    - sounds/evil-laugh-1.wav
    - sounds/evil-laugh-2.wav
    - sounds/evil-laugh-3.wav
    - sounds/howling-wind.wav
*/

class SoundManager {
  AudioPlayer player = AudioPlayer();

  Column getAudioPlayer() {
    final player1 = AudioPlayer();
    final duration1 = player1.setAsset('sounds/dramatic-organ-a.wav');

    final player2 = AudioPlayer();
    final duration2 = player2.setAsset('sounds/dramatic-organ-b.wav');

    final player3 = AudioPlayer();
    final duration3 = player3.setAsset('sounds/evil-laugh-1.wav');

    final player4 = AudioPlayer();
    final duration4 = player4.setAsset('sounds/evil-laugh-2.wav');

    final player5 = AudioPlayer();
    final duration5 = player5.setAsset('sounds/evil-laugh-3.wav');

    final player6 = AudioPlayer();
    final duration6 = player6.setAsset('sounds/howling-wind.wav');

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

    ],);
  }
}
