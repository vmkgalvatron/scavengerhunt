import 'package:flutter/material.dart';
import 'package:scavenger_hunt/models/game.dart';
import 'package:scavenger_hunt/models/player.dart';
import 'package:scavenger_hunt/screens/live_game.dart';
import 'package:scavenger_hunt/services/database.dart';
import 'package:scavenger_hunt/widgets/loading_dialog.dart';
import 'package:scavenger_hunt/widgets/textfield_with_title.dart';
import 'live_game.dart';

class JoinGame extends StatefulWidget {
  @override
  _JoinGameState createState() => _JoinGameState();
}

class _JoinGameState extends State<JoinGame> {
  String playerName = '';
  String joinCode = '';
  GlobalKey<FormState> key = GlobalKey<FormState>();
  Database _db = Database();

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
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
              shrinkWrap: true,
              children: [
                Icon(
                  Icons.adjust,
                  size: 120,
                  color: Colors.deepPurple,
                ),
                TextFieldWithTitle('Player Name', (_) {
                  playerName = _;
                }),
                TextFieldWithTitle('Game Code', (_) {
                  joinCode = _;
                }),
                ElevatedButton(
                  onPressed: () async {
                    if (key.currentState.validate()) {
                      showLoaderDialog(context);
                      _db.joinGame(joinCode, Player(playerName)).then((value) {
                        Navigator.pop(context);
                        if (value['result'] == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'The game you are looking for is ended or does not exist.',
                              ),
                            ),
                          );
                        } else if (value['result'] == 1) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'The game you are looking for is full',
                              ),
                            ),
                          );
                        } else if (value['result'] == 2) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'You have already joined this game',
                              ),
                            ),
                          );
                        } else {
                          Game game = Game.fromJson(value['game']);
                          game.id = value['gameId'];
                          //player and game have to be passed.
                          Player player = Player(playerName);
                          player.id = value['playerId'];
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LiveScreen(game, player),
                            ),
                          );
                        }
                      });
                    }
                  },
                  child: Text(' Join Game '),
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
}
