import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:shake/shake.dart';

class Shakeyyy extends StatefulWidget {
  const Shakeyyy({super.key});

  @override
  State<Shakeyyy> createState() => _ShakeyyyState();
}

class _ShakeyyyState extends State<Shakeyyy> {
  final audioPlayer = AudioPlayer();
  void _audioPath() async {
    await audioPlayer.setSource(AssetSource('siren.mp3'));
  }

  void _playAudio() async {
    await audioPlayer.resume();
  }

  @override
  void initState() {
    super.initState();
    _audioPath();

    ShakeDetector detector = ShakeDetector.autoStart(
      onPhoneShake: () async {
        _playAudio();
      },
      minimumShakeCount: 2,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text('hi');
  }
}
