import 'dart:math';

// import 'package:audioplayers/audioplayers.dart';
import 'package:background_sms/background_sms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riderapp/db/db_services.dart';
import 'package:riderapp/models/contactsm.dart';
import 'package:sensors_plus/sensors_plus.dart';

class ShakePages extends StatefulWidget {
  const ShakePages({super.key});

  @override
  State<ShakePages> createState() => _ShakePagesState();
}

class _ShakePagesState extends State<ShakePages> {
  Position? _curentPosition;
  String? _curentAddress;
  LocationPermission? permission;
  // final audioPlayer = AudioPlayer();

  // void _audioPath() async {
  //   await audioPlayer.setSource(AssetSource('siren.mp3'));
  // }

  // void _playAudio() async {
  //   await audioPlayer.resume();
  // }

  var shakeThresholdGravity = 2.7;
  int mShakeTimestamp = DateTime.now().millisecondsSinceEpoch;
  int mShakeCount = 0;
  int shakeCountResetTime = 3000;
  bool isSwitched = false;
  int shakeSlopTimeMS = 500;
  int minimumShakeCount = 2;

  @override
  void initState() {
    super.initState();
    _getPermission();
    _getCurrentLocation();
    // _audioPath();
  }

  shakeGesture() {
    accelerometerEvents.listen(
      (AccelerometerEvent event) async {
        double x = event.x;
        double y = event.y;
        double z = event.z;

        double gX = x / 9.80665;
        double gY = y / 9.80665;
        double gZ = z / 9.80665;

        // gForce will be close to 1 when there is no movement.
        double gForce = sqrt(gX * gX + gY * gY + gZ * gZ);

        if (gForce > shakeThresholdGravity) {
          var now = DateTime.now().millisecondsSinceEpoch;
          // ignore shake events too close to each other (500ms)
          if (mShakeTimestamp + shakeSlopTimeMS > now) {
            return;
          }

          // reset the shake count after 3 seconds of no shakes
          if (mShakeTimestamp + shakeCountResetTime < now) {
            mShakeCount = 0;
          }

          mShakeTimestamp = now;
          mShakeCount++;

          if (mShakeCount == minimumShakeCount && isSwitched == true) {
            print(isSwitched);
            List<TContact> contactList =
                await DatabaseHelper().getContactList();
            var status = await Permission.phone.status;
            if (status.isGranted) {
              if (mounted) {
                contactList.forEach((element) {
                  FlutterPhoneDirectCaller.callNumber(element.number);
                });
              }
            } else {
              var statuss = await Permission.phone.request();
              if (statuss.isGranted) {
                for (var element in contactList) {
                  FlutterPhoneDirectCaller.callNumber(element.number);
                }
              } else {
                Permission.phone.request();
                showDialog(
                  context: context,
                  builder: (context) => const AlertDialog(
                    content: Text("Can't call"),
                  ),
                );
              }
            }

            String messageBody =
                "https://www.google.com/maps/search/?api=1&query=${_curentPosition!.latitude}%2C${_curentPosition!.longitude}. $_curentAddress";
            if (await _isPermissionGranted()) {
              //if((await _supportCustomSim)!)
              for (var element in contactList) {
                _sendSms(element.number, "I am in trouble $messageBody");
              }
            } else {
              _getPermission();
              Fluttertoast.showToast(msg: "something wrong");
            }
            // _playAudio();
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Shaked ")));
          }
        }
      },
    );
  }

  _getPermission() async => await [Permission.sms].request();
  _isPermissionGranted() async => await Permission.sms.status.isGranted;
  _sendSms(String phoneNumber, String message, {int? simSlot}) async {
    SmsStatus result = await BackgroundSms.sendMessage(
        phoneNumber: phoneNumber, message: message, simSlot: 1);
    if (result == SmsStatus.sent) {
      print("Sent");
      Fluttertoast.showToast(msg: "send");
    } else {
      Fluttertoast.showToast(msg: "failed");
    }
  }

  _getCurrentLocation() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      Fluttertoast.showToast(msg: "Location permissions are  denind");
      if (permission == LocationPermission.deniedForever) {
        Fluttertoast.showToast(
            msg: "Location permissions are permanently denind");
      }
    }
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _curentPosition = position;
        print(_curentPosition!.latitude);
      });
    }).catchError((e) {
      Fluttertoast.showToast(msg: e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Expanded(
          child: ListTile(
            title: Text("Activate shake detection"),
            subtitle: Text(
                "Shake your phone twice to send emergency message and autocall your trusted comtacts."),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        FlutterSwitch(
            value: isSwitched,
            activeColor: Colors.green,
            inactiveColor: Colors.purple,
            onToggle: (val) {
              setState(() {
                isSwitched = val;
              });
              // if (isSwitched == true) {
              shakeGesture();
              // }
            }),
      ],
    );

    // SizedBox(
    //   height: 30,
    // ),

    //to get current location
    // InkWell(
    //   onTap: () => _getCurrentLocation(),
    //   // onTap:()=>,
    //   child: getLocation(),
    // ),
    //to send current location directly through message to trusted contacts
    //   ],
    // );
  }
}
