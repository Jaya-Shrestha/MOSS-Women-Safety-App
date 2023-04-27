import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import '../../db/db_services.dart';
import '../../models/contactsm.dart';

class CallPerson extends StatelessWidget {
  const CallPerson({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
            onTap: () async {
              List<TContact> contactList =
                  await DatabaseHelper().getContactList();
              for (var element in contactList) {
                FlutterPhoneDirectCaller.callNumber(element.number);
              }
              // showModalCallTrusted(context);
            },
            child: SizedBox(
              height: 80,
              child: Card(
                color: Theme.of(context).colorScheme.background,
                child: const ListTile(
                  title: Text("Call Emergency"),
                  subtitle: Text("Make Trusted Contacts Calls"),
                ),
              ),
            )),
        InkWell(
            onTap: () async {
              FlutterPhoneDirectCaller.callNumber('100');
              // showModalCallTrusted(context);
            },
            child: SizedBox(
              height: 80,
              child: Card(
                color: Theme.of(context).colorScheme.background,
                child: const ListTile(
                  title: Text("Police Station"),
                  subtitle: Text("Make Calls to Police"),
                ),
              ),
            )),
        InkWell(
            onTap: () async {
              FlutterPhoneDirectCaller.callNumber('112');
              // showModalCallTrusted(context);
            },
            child: SizedBox(
              height: 80,
              child: Card(
                color: Theme.of(context).colorScheme.background,
                child: const ListTile(
                  title: Text("Ambulance Service"),
                  subtitle: Text("Make Calls for Ambulance"),
                ),
              ),
            )),
      ],
    );
  }
}


// showModalCallTrusted(BuildContext context) {
//     showModalBottomSheet(
//         context: context,
//         builder: (context) {
//           return Container(
//               height: MediaQuery.of(context).size.height / 1.5,
//               decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(50),
//                     topRight: Radius.circular(50),
//                   )),
//               child: Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Column(children: [
//                     const Text("MAKE A CALL",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 20,
//                         )),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     PrimaryButton(
//                         title: " TRUSTED CONTACTS",
//                         onPressed: () async {
//                           List<TContact> contactList =
//                               await DatabaseHelper().getContactList();
//                           for (var element in contactList) {
//                             FlutterPhoneDirectCaller.callNumber(element.number);
//                           }
//                         }),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     PrimaryButton(
//                         title: " POLICE",
//                         onPressed: () {
//                           FlutterPhoneDirectCaller.callNumber('100');
//                         }),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     PrimaryButton(
//                         title: " AMBULANCE",
//                         onPressed: () {
//                           FlutterPhoneDirectCaller.callNumber('112');
//                         }),
//                   ])));
//         });
//   }