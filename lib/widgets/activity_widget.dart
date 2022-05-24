import 'package:flutter/material.dart';

class ActivityWidget extends StatelessWidget {
  const ActivityWidget({
    @required this.activity,
  });
  final String activity;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(activity),
      trailing: Icon(Icons.keyboard_arrow_right)
    );
  }
}