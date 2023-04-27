// ignore_for_file: unused_local_variable

import 'package:audioplayers/audioplayers.dart';
import 'package:background_sms/background_sms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shake/shake.dart';

import '../db/db_services.dart';
import '../models/contactsm.dart';

class ShakePage extends StatefulWidget {
  const ShakePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ShakePageState createState() => _ShakePageState();
}

class _ShakePageState extends State<ShakePage> {
  // final audioPlayer = AudioPlayer();

  // void _audioPath() async {
  //   await audioPlayer.setSource(AssetSource('siren.mp3'));
  // }

  // void _playAudio() async {
  //   await audioPlayer.resume();
  // }

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
      Fluttertoast.showToast(msg: "Location permissions");

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

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    // _audioPath();
    ShakeDetector detector = ShakeDetector.autoStart(
      onPhoneShake: () async {
        // _playAudio();

        List<TContact> contactList = await DatabaseHelper().getContactList();
        for (var element in contactList) {
          FlutterPhoneDirectCaller.callNumber(element.number);
        }

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

        // Do stuff on phone shake
      },
      minimumShakeCount: 3,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );

    // To close: detector.stopListening();
    // ShakeDetector.waitForStart() waits for user to call detector.startListening();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
