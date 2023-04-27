import 'package:flutter/material.dart';

Color primaryColor = Colors.purple;

void goTo(BuildContext context, Widget nextScreen) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => nextScreen,
      ));
}

dialogueBox(BuildContext context, String text) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(text),
    ),
  );
}

Widget progressIndicator(BuildContext context) {
  return Center(
      child: CircularProgressIndicator(
    backgroundColor: primaryColor,
    color: Colors.red,
    strokeWidth: 7,
  ));
}

void fieldFocus(
    BuildContext context, FocusNode currentNode, FocusNode nextFocus) {
  currentNode.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}
