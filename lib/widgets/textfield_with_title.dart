import 'package:flutter/material.dart';

class TextFieldWithTitle extends StatefulWidget {
  TextFieldWithTitle(this._fieldName, this._onTextChanged);
  Function _onTextChanged;
  String _fieldName;

  @override
  _TextFieldWithTitleState createState() => _TextFieldWithTitleState();
}

class _TextFieldWithTitleState extends State<TextFieldWithTitle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget._fieldName),
          Container(
            child: TextFormField(
              validator: (String current) {
                String returnText = '';
                if (current == '')
                  returnText = '${widget._fieldName} required';
                else
                  return null;
                return returnText;
              },
              onChanged: (String currentText) {
                widget._onTextChanged(currentText);
              },
            ),
          )
        ],
      ),
    );
  }
}
