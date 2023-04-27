import 'package:background_sms/background_sms.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riderapp/components/miscwidgets/primary_button.dart';
import 'package:riderapp/db/db_services.dart';
import 'package:riderapp/models/contactsm.dart';

class SendMessage extends StatefulWidget {
  const SendMessage({super.key});

  @override
  State<SendMessage> createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  Position? _currentPosition;
  String? _currentAddress;
  LocationPermission? permission;
  _getPermission() async => await [Permission.sms].request();
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
      Fluttertoast.showToast(msg: "Location permissions are denied");

      if (permission == LocationPermission.deniedForever) {
        Fluttertoast.showToast(
            msg: "Location permissions are permanently denied");
      }
    }
    Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,

      // forceAndroidLocationManager: true
    )
        .then((Position position) => setState(
              () {
                _currentPosition = position;
                // _getAddressFromLatLong();
              },
            ))
        .catchError((e) {
      Fluttertoast.showToast(msg: e.toString());
    });
  }

  // _getAddressFromLatLong() async {
  //   try {
  //     List<Placemark> placemarks = await placemarkFromCoordinates(
  //         _currentPosition!.latitude, _currentPosition!.longitude);
  //     Placemark place = placemarks[0];
  //     setState(() {
  //       _currentAddress =
  //           "${place.locality},${place.street},${place.postalCode}";
  //     });
  //   } catch (e) {
  //     Fluttertoast.showToast(msg: e.toString());
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _getPermission();
    _getCurrentLocation();
  }

  // showModalSendMessage(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (context) {
  //       return Container(
  //         height: MediaQuery.of(context).size.height / 1.5,
  //         decoration: const BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(50),
  //               topRight: Radius.circular(50),
  //             )),
  //         child: Padding(
  //           padding: const EdgeInsets.all(10.0),
  //           child: Column(
  //             children: [
  //               const Text("SEND YOUR CURRENT LOCATION",
  //                   textAlign: TextAlign.center,
  //                   style: TextStyle(
  //                     fontSize: 20,
  //                   )),
  //               const SizedBox(
  //                 height: 20,
  //               ),
  //               if (_currentPosition != null) (Text(_currentAddress!)),
  //               PrimaryButton(
  //                   title: "GET LOCATION",
  //                   onPressed: () {
  //                     _getCurrentLocation();
  //                   }),
  //               const SizedBox(
  //                 height: 10,
  //               ),
  //               PrimaryButton(
  //                   title: "SEND ALERT",
  //                   onPressed: () async {
  //                     List<TContact> contactList =
  //                         await DatabaseHelper().getContactList();

  //                     String messageBody =
  //                         'https://www.google.com/maps/search/?api=1&query=${_currentPosition!.latitude}%2C${_currentPosition!.longitude}.$_currentAddress';
  //                     if (await _isPermissionGranted()) {
  //                       for (var element in contactList) {
  //                         _sendSMS(
  //                           element.number,
  //                           "I'm in danger,Please check this message and reach me out at $messageBody",
  //                           simslot: 1,
  //                         );
  //                       }
  //                     } else {
  //                       Fluttertoast.showToast(msg: "Something went Wrong");
  //                     }
  //                   }),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        List<TContact> contactList = await DatabaseHelper().getContactList();

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
      },
      //  showModalSendMessage(context),
      child: SizedBox(
          height: 80,
          child: Card(
            color: Theme.of(context).colorScheme.background,
            child: ListTile(
              title: Text("Send Location"),
              subtitle: Text("Share Location"),
            ),
          )),
    );
  }
}
