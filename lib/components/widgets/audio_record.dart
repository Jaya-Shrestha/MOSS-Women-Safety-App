import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

// ignore: camel_case_types
class audio_recorder extends StatefulWidget {
  const audio_recorder({super.key});

  @override
  State<audio_recorder> createState() => _audio_recorderState();
}

// ignore: camel_case_types
class _audio_recorderState extends State<audio_recorder> {
  final recorder = FlutterSoundRecorder();
  bool isRecorderReady = false;

  @override
  void initState() {
    super.initState();
    initRecorder();
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      throw 'Microphone Permission Not Granted';
    }

    await recorder.openRecorder();

    isRecorderReady = true;

    recorder.setSubscriptionDuration(
      const Duration(milliseconds: 500),
    );
  }

  Future record() async {
    if (!isRecorderReady) return;
    await recorder.startRecorder(toFile: 'audio');
  }

  Future stop() async {
    if (!isRecorderReady) return;
    await recorder.stopRecorder();
    final path = await recorder.stopRecorder();
    final audioFile = File(path!);

    print('Recorded audio: $audioFile');
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        showModalAudioRecord(context);
      },
      child: SizedBox(
          height: 80,
          child: Card(
            color: Theme.of(context).colorScheme.background,
            child: const ListTile(
              title: Text("Record Audio"),
              subtitle: Text("Start recording in case of emergency"),
            ),
          )),
    );
  }

  showModalAudioRecord(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              height: MediaQuery.of(context).size.height / 1.5,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  )),
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(children: [
                    Text("AUDIO RECORDER",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    StreamBuilder<RecordingDisposition>(
                      stream: recorder.onProgress,
                      builder: (context, snapshot) {
                        final duration = snapshot.hasData
                            ? snapshot.data!.duration
                            : Duration.zero;

                        String twoDigits(int n) => n.toString().padLeft(2);
                        final twoDigitMinutes =
                            twoDigits(duration.inMinutes.remainder(60));
                        final twoDigitSeconds =
                            twoDigits(duration.inSeconds.remainder(60));

                        return Text(
                          '$twoDigitMinutes:$twoDigitSeconds',
                          style: const TextStyle(
                            fontSize: 80,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    ElevatedButton(
                      child: Icon(
                        recorder.isRecording ? Icons.stop : Icons.mic,
                        size: 80,
                      ),
                      onPressed: () async {
                        if (recorder.isRecording) {
                          await stop();
                        } else {
                          await record();
                        }
                        setState(() {});
                      },
                    ),
                  ])));
        });
  }
}
