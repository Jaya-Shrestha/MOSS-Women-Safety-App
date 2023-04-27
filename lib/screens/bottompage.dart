import 'package:flutter/material.dart';
import 'package:riderapp/screens/bottomscreens/add_contacts.dart';
import 'package:riderapp/screens/bottomscreens/home_screen.dart';
import 'package:riderapp/screens/bottomscreens/sos_screen.dart';
import 'package:riderapp/screens/bottomscreens/laws/law_session.dart';

import 'bottomscreens/community_screens/community_page.dart';
// import 'bottomscreens/fingerprint.dart';

class BottomPage extends StatefulWidget {
  const BottomPage({super.key});

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  int currentIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const SosScreen(),
    // const AddContactsPage(),
    const CommunityPage(),
    // const FingerprintPage(),
    const AddContactsPage(),
    const LawSession(),
  ];
  onTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: onTapped,
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'SOS',
              icon: Icon(Icons.sos),
            ),
            BottomNavigationBarItem(
              label: 'Community',
              icon: Icon(Icons.groups),
            ),
            BottomNavigationBarItem(
              label: 'Contacts',
              icon: Icon(Icons.call),
            ),
            BottomNavigationBarItem(
              label: 'Law',
              icon: Icon(Icons.security),
            ),
          ]),
    );
  }
}
