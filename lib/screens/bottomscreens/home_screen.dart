// ignore_for_file: deprecated_member_use, unused_import
import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:background_sms/background_sms.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
// import 'package:riderapp/components/mapbox/lastdemo.dart';
import 'package:riderapp/components/mapbox/random.dart';
import 'package:riderapp/components/widgets/voice_cmd.dart';
import 'package:riderapp/providers/places_data.dart';
import 'package:riderapp/screens/bottomscreens/add_contacts.dart';
import 'package:riderapp/screens/example4.dart';
import 'package:riderapp/screens/shake_page.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/mapbox/mappage.dart';
import '../../components/mapbox/redzone.dart';
import '../../components/mapbox/redzones.dart';
import '../../db/db_services.dart';
import '../../main.dart';
import '../../models/contactsm.dart';
import '../drawer_screens/drawer.dart';
import '../../components/live_safe.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var responses;
  SpeechToText speechToText = SpeechToText();
  bool _isListening = false;
  String _text = 'Press the button and start speaking'
      // ,
      // \n Commands are :  \n  Help for Sending SMS \n Play for Siren \n Stop for Stopping alarm \n Police for Calling Police \n Ambulance for Calling Ambulance '
      ;
  final audioPlayer = AudioPlayer();

  void _audioPath() async {
    await audioPlayer.setSource(AssetSource('siren.mp3'));
  }

  void _playAudio() async {
    await audioPlayer.resume();
  }

  void _stopAudio() async {
    await audioPlayer.pause();
  }

  @override
  void initState() {
    _getCurrentLocation();
    // _getNearestPlaces();
    _audioPath();
    super.initState();
  }

  Position? _currentPosition;
  String? _currentAddress;
  LocationPermission? permission;
  _isPermissionGranted() async => await Permission.sms.status.isGranted;
  _sendSMS(String phoneNumber, String message, {int? simslot}) async {
    SmsStatus result = await BackgroundSms.sendMessage(
        phoneNumber: phoneNumber, message: message, simSlot: simslot);
    if (result == SmsStatus.sent) {
      Fluttertoast.showToast(msg: 'Sent');
    } else {
      Fluttertoast.showToast(msg: 'Failed');
    }
  }

  _getCurrentLocation() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.denied) {
        Fluttertoast.showToast(msg: "Location permissions successful");
      }
      if (permission == LocationPermission.deniedForever) {
        Fluttertoast.showToast(
            msg: "Location permissions are permanently denied");
      }
    }
    Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    ).then((Position position) => setState(
          () {
            _currentPosition = position;
          },
        ));
  }

  Future<void> _getNearestPlaces() async {
    responses = await Dio().post(
        'https://redzone-production.up.railway.app/location/nearestredzone/',
        data: {
          "longitude": _currentPosition!.longitude,
          "latitude": _currentPosition!.latitude
        });
    print(responses.data);
  }

  @override
  Widget build(BuildContext context) {
    final myDataModel = Provider.of<PlacesData>(context, listen: false);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Explore",
                  // textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const LiveSafe(),
            const SizedBox(
              height: 20,
            ),
            InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MapPage()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(9),
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Get Location",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RedZonePage()));
                  _getNearestPlaces();
                  // Timer.periodic(const Duration(seconds: 2), (Timer t) {
                  myDataModel.title = responses.data['title'];
                  myDataModel.latitude = responses.data['latitude'];
                  myDataModel.longitude = responses.data['longitude'];
                  myDataModel.location = responses.data['location'];
                  myDataModel.cause = responses.data['cause'];
                  myDataModel.url = responses.data['url'];
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const RedZonePage()));
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => NearestZone(
                  //             responses.data['latitude'],
                  //             responses.data['longitude'],
                  //             responses.data['location'],
                  //             responses.data['cause'],
                  //             responses.data['url'],
                  //             responses.data['title'])));
                  // });
                  //
                  //
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(9),
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Red Zone Area",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Text(
                  _text,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      const Text("Give Commands:",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.email_rounded,
                            size: 30,
                            color: Colors.purple,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("HELP : Sending SMS",
                              style: TextStyle(
                                fontSize: 18,
                              ))
                        ],
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.music_note,
                            size: 30,
                            color: Colors.purple,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "PLAY : Siren/False Alarm",
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.pause_circle,
                            size: 30,
                            color: Colors.purple,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("STOP : Stoping Siren",
                              style: TextStyle(fontSize: 18))
                        ],
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.local_police_outlined,
                            size: 30,
                            color: Colors.purple,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("POLICE : Call Police",
                              style: TextStyle(fontSize: 18))
                        ],
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.emergency,
                            size: 30,
                            color: Colors.purple,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("AMBULANCE : Call Ambulance",
                              style: TextStyle(fontSize: 18))
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            const ShakePage(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: Theme.of(context).colorScheme.secondary,
        endRadius: 75.0,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        showTwoGlows: true,
        child: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.background,
          radius: 30,
          child: GestureDetector(
            onTapDown: (details) async {
              if (!_isListening) {
                bool available = await speechToText.initialize();
                if (available) {
                  setState(() {
                    _isListening = true;
                  });
                  speechToText.listen(
                    onResult: (result) async {
                      setState(() {
                        _text = result.recognizedWords;
                      });
                      if (_text.toLowerCase() == 'help') {
                        List<TContact> contactList =
                            await DatabaseHelper().getContactList();

                        String messageBody =
                            'https://www.google.com/maps/search/?api=1&query=${_currentPosition!.latitude}%2C${_currentPosition!.longitude}.$_currentAddress';
                        if (await _isPermissionGranted()) {
                          for (var element in contactList) {
                            _sendSMS(
                              element.number,
                              "I'm in danger,Please check this message and reach me out at $messageBody",
                              simslot: 1,
                            );
                          }
                        } else {
                          Fluttertoast.showToast(msg: "Something went Wrong");
                        }
                      }
                      if (_text.toLowerCase() == 'play') {
                        _playAudio();
                      }
                      if (_text.toLowerCase() == 'stop') {
                        _stopAudio();
                      }
                      if (_text.toLowerCase() == 'police') {
                        FlutterPhoneDirectCaller.callNumber('100');
                      }
                      if (_text.toLowerCase() == 'ambulance') {
                        FlutterPhoneDirectCaller.callNumber('112');
                      }
                    },
                  );
                }
              }
            },
            onTapUp: ((details) {
              setState(() {
                _isListening = false;
                speechToText.stop();
              });
            }),
            child: Icon(
              _isListening ? Icons.mic : Icons.mic_none,
              color: Theme.of(context).colorScheme.onSecondary,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }
}
