// // ignore_for_file: use_build_context_synchronously
// import 'package:flutter/services.dart';
// import 'package:local_auth/local_auth.dart';
// import 'package:flutter/material.dart';
// // import 'package:riderapp/screens/bottomscreens/community_screens/community_page.dart';
// import 'package:riderapp/screens/drawer_screens/about_us.dart';

// class FingerprintPage extends StatefulWidget {
//   const FingerprintPage({super.key});

//   @override
//   State<FingerprintPage> createState() => _FingerprintPageState();
// }

// class _FingerprintPageState extends State<FingerprintPage> {
//   final LocalAuthentication auth = LocalAuthentication();

//   late bool _canCheckBiometrics;

//   List<BiometricType>? _availableBiometrics;

//   String authorized = 'Not Authorized';

//   Future<void> _checkBiometrics() async {
//     bool canCheckBiometrics;
//     try {
//       canCheckBiometrics = await auth.canCheckBiometrics;
//     } on PlatformException catch (e) {
//       canCheckBiometrics = false;
//       print(e);
//     }
//     if (!mounted) {
//       return;
//     }

//     setState(() {
//       _canCheckBiometrics = canCheckBiometrics;
//     });
//   }

//   Future<void> _getAvailableBiometrics() async {
//     late List<BiometricType> availableBiometrics;
//     try {
//       availableBiometrics = await auth.getAvailableBiometrics();
//     } on PlatformException catch (e) {
//       availableBiometrics = <BiometricType>[];
//       print(e);
//     }
//     if (!mounted) {
//       return;
//     }

//     setState(() {
//       _availableBiometrics = availableBiometrics;
//     });
//   }

//   Future<void> _authenticateWithBiometrics() async {
//     bool authenticated = false;
//     try {
//       authenticated = await auth.authenticate(
//         localizedReason:
//             'Scan your fingerprint (or face or whatever) to authenticate',
//         options: const AuthenticationOptions(
//           stickyAuth: false,
//           biometricOnly: true,
//           useErrorDialogs: true,
//         ),
//       );
//     } on PlatformException catch (e) {
//       print(e);
//     }
//     if (!mounted) {
//       return;
//     }
//     setState(() {
//       authorized = authenticated ? 'Authorize Succes' : 'Failed to authorize';
//       if (authenticated) {
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => AboutUs()));
//       }
//       // print(authorized);
//     });
//   }

//   @override
//   void initState() {
//     _checkBiometrics();
//     _getAvailableBiometrics();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
//         child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//           const Center(
//             child: Text('Fingerprint',
//                 style: TextStyle(fontSize: 46.0, fontWeight: FontWeight.bold)),
//           ),
//           Container(
//             margin: const EdgeInsets.symmetric(vertical: 50.0),
//             width: 2000.0,
//             child: Column(
//               children: [
//                 Image.asset('assets/fingerprint.png'),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 const Text(
//                   'Fingerprint Authorization',
//                   style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
//                 ),
//                 Container(
//                   width: 150.0,
//                   child: const Text(
//                     'Authenticate using your fingerprint to enter .',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 18.0,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   width: MediaQuery.of(context).size.width * 2,
//                   child: ElevatedButton(
//                     // ...
//                     onPressed: _authenticateWithBiometrics,
//                     //() async {
//                     //   bool isAuthenticated =
//                     //       await Authentication.authenticateWithBiometrics();

//                     //   if (isAuthenticated) {
//                     //     Navigator.of(context).push(
//                     //       MaterialPageRoute(
//                     //         builder: (context) => AboutUs(),
//                     //       ),
//                     //     );
//                     //   }
//                     // },
//                     child: const Text("Authenticate"),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ]),
//       ),
//     ));
//   }
// }

// // class Authentication {
// //   static Future<bool> authenticateWithBiometrics() async {
// //     final LocalAuthentication localAuthentication = LocalAuthentication();
// //     bool isBiometricSupported = await localAuthentication.isDeviceSupported();
// //     bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;

// //     bool isAuthenticated = false;

// //     if (isBiometricSupported && canCheckBiometrics) {
// //       isAuthenticated = await localAuthentication.authenticate(
// //         localizedReason: 'Please complete the biometrics to proceed.',
// //         options: const AuthenticationOptions(
// //           biometricOnly: true,
// //         ),
// //       );
// //     }

// //     return isAuthenticated;
// //   }
// // }
