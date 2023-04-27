import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'comment_bubble.dart';

class Comments extends StatelessWidget {
  const Comments(this.confId);

  final String confId;

  @override
  Widget build(BuildContext context) {
    print(confId);
    print('error');
    return FutureBuilder(
      future: Future.value(FirebaseAuth.instance.currentUser),
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('comments')
              .where('confessionId', isEqualTo: confId)
              .orderBy(
                'createdAt',
                descending: true,
              )
              .snapshots(),
          builder: (ctx, commentSnapshot) {
            if (commentSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (commentSnapshot.hasError) {
              return Text('Error: ${commentSnapshot.error}');
            }
            if (!commentSnapshot.hasData || commentSnapshot.data!.size == 0) {
              return const Text('No data available.');
            }
            final comDocs = commentSnapshot.data!.docs;
            return ListView.builder(
              reverse: true,
              itemCount: comDocs.length,
              itemBuilder: (ctx, index) {
                return CommentBubble(
                  comDocs[index]['text'],
                  comDocs[index]['username'],
                  comDocs[index]['userId'] == futureSnapshot.data!.uid,
                  key: ValueKey(comDocs[index].reference.id),
                );
              },
            );
          },
        );
      },
    );
  }
}
