import 'package:flutter/material.dart';

class AppbarWithEditOption extends StatefulWidget {
  AppbarWithEditOption(this.initialName, this.isEditable, {this.onNameChanged});
  Function onNameChanged;
  String initialName;
  bool isEditable;

  @override
  _AppbarWithEditOptionState createState() => _AppbarWithEditOptionState();
}

class _AppbarWithEditOptionState extends State<AppbarWithEditOption> {
  bool _startedEditing = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: _startedEditing
          ? TextFormField(
              autofocus: true,
              initialValue: widget.initialName,
              validator: (String current) {
                String returnText = '';
                if (current == '') returnText = 'Game name is required';
                return returnText;
              },
              onChanged: (String currentText) {
                widget.onNameChanged(currentText);
                widget.initialName = currentText;
              },
            )
          : Text(widget.initialName),
      actions: [
        _startedEditing
            ? IconButton(
                icon: Icon(Icons.done),
                onPressed: () {
                  setState(
                    () {
                      FocusScope.of(context).unfocus();
                      _startedEditing = false;
                    },
                  );
                },
              )
            : IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  setState(
                    () {
                      _startedEditing = true;
                    },
                  );
                },
              )
      ],
    );
  }
}
