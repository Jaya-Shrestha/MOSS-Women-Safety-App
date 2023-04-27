import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:riderapp/screens/drawer_screens/user_demo.dart';
import '../../../screens/drawer_screens/about_us.dart';
import 'user_profile.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({super.key});
  final user = FirebaseAuth.instance.currentUser!;

  final firstname = FirebaseAuth.instance.currentUser!.displayName;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 255.0,
        child: Drawer(
          child: ListView(
            children: [
              AppBar(
                title: const Text('Hello User!'),
              ),
              // Drawer header
              InkWell(
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Visit Profile'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserProfile()),
                    );
                  },
                ),
              ),
              // Drawer body Controllers
              // InkWell(
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => const UserDemo()),
              //     );
              //   },
              //   child: const ListTile(
              //     leading: Icon(Icons.info),
              //     title: Text(
              //       'About',
              //       style: TextStyle(
              //         fontSize: 15.0,
              //       ),
              //     ),
              //   ),
              // ),

              // ShakePage(),
              const InkWell(
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                  onTap: signUserOut,
                ),
              ),
            ],
          ),
        ));
  }
}

void signUserOut() {
  FirebaseAuth.instance.signOut();
}
