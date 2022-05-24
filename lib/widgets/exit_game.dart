import 'package:flutter/material.dart';

Future<bool> showExitDialogue(context, String name) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      String text = '';
      return AlertDialog(
        title: Text('Exit game?'),
        content: Container(
          child: Text("Do you want to leave game " + name + " ?"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text('Cancel'),
          ),
          TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text('Exit'))
        ],
      );
    },
  );
}
