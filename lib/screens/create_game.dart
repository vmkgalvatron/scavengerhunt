import 'package:flutter/material.dart';
import 'package:scavenger_hunt/widgets/textfield_with_title.dart';
import 'new_game.dart';

class CreateGame extends StatefulWidget {
  @override
  _CreateGameState createState() => _CreateGameState();
}

class _CreateGameState extends State<CreateGame> {
  String hostName = '';
  String gameName = '';
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Center(
          child: Form(
            key: key,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
              children: [
                Icon(
                  Icons.adjust,
                  size: 120,
                  color: Colors.purple,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                  child: Text(
                    'Please enter details before we host the game.',
                    style: TextStyle(fontSize: 17),
                    textAlign: TextAlign.center,
                  ),
                ),
                TextFieldWithTitle('Host name', onHostNameChanged),
                TextFieldWithTitle('Game name', onGameNameChanged),
                ElevatedButton(
                  child: Text(' Create Game '),
                  onPressed: () async {
                    if (key.currentState.validate()) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewGame(gameName, hostName),
                        ),
                      );
                    }
                  },
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [Icon(Icons.home), Text("Return home")],
                    mainAxisSize: MainAxisSize.min,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onHostNameChanged(String newHostName) {
    hostName = newHostName;
  }

  void onGameNameChanged(String newGameName) {
    gameName = newGameName;
  }
}
