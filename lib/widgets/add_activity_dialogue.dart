import 'package:flutter/material.dart';

Future<String> showAddActivityDialogue(context) {
  return showDialog<String>(
    context: context,
    builder: (context) {
      String text = '';
      return AlertDialog(
        title: Text('New Activity'),
        content: Container(
          child: TextFormField(
            decoration:
                InputDecoration(fillColor: Colors.deepPurple[50], filled: true),
            cursorColor: Colors.deepPurple[700],
            onChanged: (_) {
              text = _;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
              onPressed: () {
                Navigator.pop(context, text);
              },
              child: Text('Add'))
        ],
      );
    },
  );
}
