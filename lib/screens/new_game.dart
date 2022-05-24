import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:scavenger_hunt/models/activity.dart';
import 'package:scavenger_hunt/models/game.dart';
import 'package:scavenger_hunt/models/player.dart';
import 'package:scavenger_hunt/screens/published_game.dart';
import 'package:scavenger_hunt/services/database.dart';
import 'package:scavenger_hunt/widgets/add_activity_dialogue.dart';
import 'package:scavenger_hunt/widgets/appbar_with_edit.dart';
import 'package:scavenger_hunt/widgets/exit_game.dart';
import 'package:scavenger_hunt/widgets/loading_dialog.dart';

import '../constants.dart';

class NewGame extends StatefulWidget {
  NewGame(this.gameName, this.hostName);
  String gameName;
  String hostName;

  @override
  _NewGameState createState() => _NewGameState();
}

class _NewGameState extends State<NewGame> {
  List<Activity> activities = [];
  Database _db = Database();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            child: AppbarWithEditOption(widget.gameName, false,
                onNameChanged: onNameChanged),
            preferredSize: Size(double.maxFinite, 60),
          ),
          body: ListView.builder(
            itemCount: activities.length,
            itemBuilder: (context, x) {
              return Dismissible(
                key: Key(activities[x].title),
                child: ListTile(title: Text(activities[x].title)),
                direction: DismissDirection.endToStart,
                onDismissed: (DismissDirection dismissDirection) {
                  setState(() {
                    activities.removeAt(x);
                  });
                },
              );
            },
          ),
          bottomSheet: Container(
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.home,
                    size: 35,
                  ),
                  onPressed: () {
                    showExitDialogue(context, "this").then((value) {
                      if (value) Navigator.pop(context);
                    });
                  },
                ),
                Expanded(
                  child: Row(
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            if (activities.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Add atleast one activity to publish.',
                                  ),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            } else {
                              showLoaderDialog(context);
                              Game game;
                              String code;
                              code = randomAlphaNumeric(codeLength);
                              game = Game(widget.gameName, code);
                              Player player = Player(widget.hostName);
                              game = await _db.createGame(
                                  game, widget.hostName, activities);
                              player.id = game.hostId;
                              Navigator.pop(context);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PublishedGame(game, player),
                                ),
                              );
                            }
                          },
                          child: Text('PUBLISH')),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () async {
                          var newActivity =
                              await showAddActivityDialogue(context);
                          if (newActivity != null) {
                            setState(() {
                              activities.add(Activity(newActivity));
                            });
                          }
                        },
                        child: Text('+  ACTIVITY'),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.end,
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            margin: EdgeInsets.only(left: 20, right: 15),
          ),
        ),
      ),
    );
  }

  void onNameChanged(String newName) {
    widget.gameName = newName;
  }
}
