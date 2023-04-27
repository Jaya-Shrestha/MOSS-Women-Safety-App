// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class UserDemo extends StatefulWidget {
//   const UserDemo({super.key});

//   @override
//   State<UserDemo> createState() => _UserDemoState();
// }

// class _UserDemoState extends State<UserDemo> {
//   // final String userId = FirebaseAuth.instance.currentUser!.uid;
//   final usersRef = FirebaseFirestore.instance
//       .collection('users')
//       .doc(FirebaseAuth.instance.currentUser!.uid);
//   late File _image;
//   final picker = ImagePicker();

//   Future getImage() async {
//     final pickedFile = await picker.getImage(source: ImageSource.camera);

//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//       } else {
//         print('No image selected.');
//       }
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _image = File(''); // Initialize _image to an empty File
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8),
//               child: StreamBuilder<DocumentSnapshot>(
//                 stream: usersRef.snapshots(),
//                 builder: ((context, AsyncSnapshot snapshot) {
//                   if (snapshot.hasError) {
//                     return Text('Error: ${snapshot.error}');
//                   }

//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   }

//                   final userData = snapshot.data!.data()!;
//                   final name = userData!['username'];
//                   return Container(
//                     padding: const EdgeInsets.all(10),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         ReusableRow(
//                             title: 'Username',
//                             value: name,
//                             iconData: Icons.person_outline),
//                         ReusableRow(
//                             title: 'Fullname',
//                             value: userData!['firstname'],
//                             iconData: Icons.co_present_outlined),
//                         ReusableRow(
//                             title: 'Email',
//                             value: userData!['email'],
//                             iconData: Icons.email),
//                         ReusableRow(
//                             title: 'Phone No.',
//                             value: userData!['phonenumber'],
//                             iconData: Icons.phone),
//                       ],
//                     ),
//                   );
//                 }),
//               ),
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 _image.path.isEmpty
//                     ? const Text('No image selected.')
//                     : Image.file(_image, height: 200),
//                 ElevatedButton(
//                   onPressed: getImage,
//                   child: const Text('Pick an image'),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ReusableRow extends StatelessWidget {
//   final String title, value;
//   final IconData iconData;
//   const ReusableRow(
//       {super.key,
//       required this.title,
//       required this.value,
//       required this.iconData});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ListTile(
//           title: Text(title),
//           leading: Icon(iconData),
//           trailing: Text(value),
//         ),
//         const Divider(
//           color: Colors.grey,
//         )
//       ],
//     );
//   }
// }
