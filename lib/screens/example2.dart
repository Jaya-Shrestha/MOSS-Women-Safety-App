import 'package:flutter/material.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:audioplayers/audioplayers.dart';

class Example2 extends StatefulWidget {
  const Example2({super.key});

  @override
  State<Example2> createState() => _Example2State();
}

class _Example2State extends State<Example2> {
  final audioPlayer = AudioPlayer();

  void _audioPath() async {
    await audioPlayer.setSource(AssetSource('siren.mp3'));
  }

  @override
  void initState() {
    super.initState();
    _audioPath();
  }

  void _playAudio() async {
    await audioPlayer.resume();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ElevatedButton(
        onPressed: _playAudio,
        child: const Text("Press Me"),
      ),
    );
  }
}
