import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class NewComment extends StatefulWidget {
  NewComment(this.confId);

  final String confId;

  @override
  State<NewComment> createState() => _NewCommentState();
}

class _NewCommentState extends State<NewComment> {
  final _controller = new TextEditingController();
  var _enteredComment = '';

  void _sendComment() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    FirebaseFirestore.instance.collection('comments').add({
      'text': _enteredComment,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': userData['username'],
      'confessionId': widget.confId,
      //'confessionid': confId,
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Add a comment!'),
              onChanged: (value) {
                setState(() {
                  _enteredComment = value;
                });
              },
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: const Icon(
              Icons.send,
            ),
            onPressed: _enteredComment.trim().isEmpty ? null : _sendComment,
          )
        ],
      ),
    );
  }
}
