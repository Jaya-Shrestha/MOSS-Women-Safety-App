import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/confession.dart';
import '../../screens/bottomscreens/comment/comment_screen.dart';

class CommunityItem extends StatelessWidget {
  const CommunityItem({super.key});

  @override
  Widget build(BuildContext context) {
    final confession = Provider.of<Confession>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Confession>(
            builder: (ctx, confession, _) => IconButton(
              icon: Icon(
                  confession.isLiked ? Icons.favorite : Icons.favorite_border),
              onPressed: () {
                confession.toggleLikedStatus();
              },
              color: Theme.of(context).accentColor,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.comment),
            onPressed: () {
              //addcomment
              Navigator.of(context).pushNamed(
                CommentScreen.routeName,
                arguments: confession.id,
              );
            },
            // color: Theme.of(context).accentColor,
          ),
        ),
        child: Card(
          child: Text(confession.description),
        ),
      ),
    );
  }
}
