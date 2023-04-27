import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riderapp/screens/bottomscreens/comment/comments.dart';

import '../../../providers/community_provider.dart';
import 'new_comment.dart';

class CommentScreen extends StatelessWidget {
  // CommentScreen(this.confId);

  // var confId;
  static const routeName = '/comment-screen';

  @override
  Widget build(BuildContext context) {
    final confessionId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedConfession = Provider.of<Confessions>(
      context,
      listen: false,
    ).findById(confessionId);
    // print(loadedConfession.id);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Comments(loadedConfession.id),
            ),
            NewComment(loadedConfession.id),
            //cofessionid
          ],
        ),
      ),
    );
  }
}


// actions: [
//           DropdownButton(
//             icon: Icon(
//               Icons.more_vert,
//               color: Theme.of(context).primaryIconTheme.color,
//             ),
//             items: [
//               DropdownMenuItem(
//                 value: 'logout',
//                 child: Container(
//                   child: Row(
//                     children: const <Widget>[
//                       Icon(Icons.exit_to_app),
//                       SizedBox(width: 8),
//                       Text('Logout')
//                     ],
//                   ),
//                 ),
//               )
//             ],
//             onChanged: (itemIdentifier) {
//               if (itemIdentifier == 'logout') {
//                 FirebaseAuth.instance.signOut();
//               }
//             },
//           )
//         ],