import 'package:flutter/material.dart';
import 'package:riderapp/screens/bottompage.dart';
import 'package:riderapp/screens/bottomscreens/home_screen.dart';

import '../../screens/bottomscreens/community_screens/user_confessions_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: const Text('Hello User!'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: (() {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const BottomPage()));
            }),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Manage Posts'),
            onTap: (() {
              Navigator.of(context)
                  .pushReplacementNamed(UserConfessionsScreen.routeName);
            }),
          ),
        ],
      ),
    );
  }
}
