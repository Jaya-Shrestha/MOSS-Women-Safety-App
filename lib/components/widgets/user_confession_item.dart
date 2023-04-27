import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/community_provider.dart';
import '../../screens/bottomscreens/community_screens/edit_confession_screen.dart';

class UserConfessionItem extends StatelessWidget {
  final String id;
  final String description;

  const UserConfessionItem(this.id, this.description, {super.key});

  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(description),
      //leading: Text(description),
      // leading: CircleAvatar(
      //   backgroundImage: NetworkImage(imageUrl),
      // ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditConfessionScreen.routeName, arguments: id);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                try {
                  Provider.of<Confessions>(context, listen: false)
                      .deleteConfession(id);
                } catch (error) {
                  scaffold.showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Deleting failed!',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
