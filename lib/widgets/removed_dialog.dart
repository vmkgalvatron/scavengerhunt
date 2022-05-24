import 'package:flutter/material.dart';

Future<void> showPlayerRemovedDialog(context) {
  return showDialog<Future<void>>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        actions: [
          TextButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
        title: Text("Sorry!", style: TextStyle(color: Colors.deepPurple)),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(
            'You have been removed from the game.',
            style: TextStyle(fontSize: 20),
          ),
        ]),
      );
    },
  );
}
