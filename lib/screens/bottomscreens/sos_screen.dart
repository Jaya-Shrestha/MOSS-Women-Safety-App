import 'package:flutter/material.dart';
import 'package:riderapp/components/widgets/audio_record.dart';
import 'package:riderapp/components/widgets/call_trusted.dart';
import 'package:riderapp/components/widgets/send_msg.dart';
import 'package:riderapp/screens/example4.dart';
import '../../components/widgets/play_music.dart';
// import '../shake_page.dart';

class SosScreen extends StatefulWidget {
  const SosScreen({super.key});

  @override
  State<SosScreen> createState() => _SosScreenState();
}

class _SosScreenState extends State<SosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text('S.O.S'),
      ),
      body: Column(
        children: const [
          ShakePages(),
          // ShakePage(),
          PlaySiren(),
          SendMessage(),
          CallPerson(),
          audio_recorder(),
        ],
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: AvatarGlow(
      //   animate: _isListening,
      //   glowColor: Theme.of(context).colorScheme.secondary,
      //   endRadius: 75.0,
      //   duration: const Duration(milliseconds: 2000),
      //   repeatPauseDuration: const Duration(milliseconds: 100),
      //   repeat: true,
      //   showTwoGlows: true,
      //   child: CircleAvatar(
      //     backgroundColor: Theme.of(context).colorScheme.background,
      //     radius: 30,
      //     child: GestureDetector(
      //       onTapDown: (details) async {
      //         if (!_isListening) {
      //           bool available = await speechToText.initialize();
      //           if (available) {
      //             setState(() {
      //               _isListening = true;
      //             });
      //             speechToText.listen(
      //               onResult: (result) async {
      //                 setState(() {
      //                   _text = result.recognizedWords;
      //                 });
      //                 if (_text.toLowerCase() == 'help') {
      //                   List<TContact> contactList =
      //                       await DatabaseHelper().getContactList();

      //                   String messageBody =
      //                       'https://www.google.com/maps/search/?api=1&query=${_currentPosition!.latitude}%2C${_currentPosition!.longitude}.$_currentAddress';
      //                   if (await _isPermissionGranted()) {
      //                     for (var element in contactList) {
      //                       _sendSMS(
      //                         element.number,
      //                         "I'm in danger,Please check this message and reach me out at $messageBody",
      //                         simslot: 1,
      //                       );
      //                     }
      //                   } else {
      //                     Fluttertoast.showToast(msg: "Something went Wrong");
      //                   }
      //                 }
      //                 if (_text.toLowerCase() == 'play') {
      //                   _playAudio();
      //                 }
      //                 if (_text.toLowerCase() == 'stop') {
      //                   _stopAudio();
      //                 }
      //                 if (_text.toLowerCase() == 'police') {
      //                   FlutterPhoneDirectCaller.callNumber('100');
      //                 }
      //                 if (_text.toLowerCase() == 'ambulance') {
      //                   FlutterPhoneDirectCaller.callNumber('112');
      //                 }
      //               },
      //             );
      //           }
      //         }
      //       },
      //       onTapUp: ((details) {
      //         setState(() {
      //           _isListening = false;
      //           speechToText.stop();
      //         });
      //       }),
      //       child: Icon(
      //         _isListening ? Icons.mic : Icons.mic_none,
      //         color: Theme.of(context).colorScheme.onSecondary,
      //         size: 40,
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
