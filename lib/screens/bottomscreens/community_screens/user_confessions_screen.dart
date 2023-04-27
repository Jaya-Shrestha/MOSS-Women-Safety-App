import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riderapp/screens/bottomscreens/community_screens/edit_confession_screen.dart';

import '../../../components/widgets/app_drawer.dart';
import '../../../components/widgets/user_confession_item.dart';
import '../../../providers/community_provider.dart';

class UserConfessionsScreen extends StatelessWidget {
  static const routeName = '/user-confessions';

  const UserConfessionsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final confessionsData = Provider.of<Confessions>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Confessions'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditConfessionScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: confessionsData.items.length,
          itemBuilder: (_, i) => Column(
            children: [
              UserConfessionItem(
                confessionsData.items[i].id,
                confessionsData.items[i].description,
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
