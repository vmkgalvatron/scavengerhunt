import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:scavenger_hunt/models/game.dart';
import 'package:scavenger_hunt/models/player.dart';
import 'package:scavenger_hunt/screens/create_game.dart';
import 'package:scavenger_hunt/screens/join_game.dart';
import 'package:scavenger_hunt/screens/published_game.dart';
import 'package:scavenger_hunt/services/database.dart';
import 'package:scavenger_hunt/widgets/loading_dialog.dart';
import 'live_game.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Database _db = Database();
  List<Map<String, dynamic>> games = [];
  int gamesCount = 0;
  //SharedPrefs _prefs = SharedPrefs();

  @override
  void initState() {
    getCurrentGames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      /*appBar: AppBar(
        title: Text("Scavenger Hunt"),
        centerTitle: true,
      ),*/
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.4,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.fit_screen_sharp,
                  size: 300,
                  color: Colors.indigo[900],
                ),
                Container(
                  //color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Scavenger\nHunt",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  //color: Colors.indigo,
                  child: MaterialButton(
                    color: Colors.purple,
                    child: Text(
                      "Join Game",
                      style: TextStyle(color: Colors.white, fontSize: 23),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JoinGame(),
                        ),
                      );
                    },
                  ),
                  alignment: Alignment.center,
                ),
                Container(
                  //color: Colors.purple,
                  child: MaterialButton(
                    color: Colors.indigo,
                    child: Text(
                      "Create Game",
                      style: TextStyle(color: Colors.white, fontSize: 23),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateGame(),
                        ),
                      );
                    },
                  ),
                  alignment: Alignment.center,
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "created by,",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "Vedant Kulkarni",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "for elitmus",
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
          )
        ],
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }

  Widget hometext(String text) {
    return Container(
      width: double.maxFinite,
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
      padding: EdgeInsets.all(20),
    );
  }

  void getCurrentGames() async {
    /* List<String> gamesList = await _prefs.getGames();
    games = [];
    gamesCount = 0;
    if (gamesList != null) {
      for (int i = 0; i < gamesList.length; i++) {
        gamesCount++;
        var json = jsonDecode(gamesList[i]);
        json['gameName'] = jsonDecode(json['gameName']);
        json['player'] = jsonDecode(json['player']);
        games.add(json);
      }
      setState(() {});
    }*/
  }
}

 /*ListView(
        children: [
          if (gamesCount == 0) hometext('Welcome to scavenger hunt'),
          if (gamesCount == 0) hometext('Host a game or join a game.'),
          for (int i = 0; i < gamesCount; i++)
            Column(
              children: [
                ListTile(
                  tileColor: Colors.white,
                  title: Text(games[i]['gameName']['name']),
                  onTap: () async {
                    Player player = Player.fromJson(games[i]['player']);
                    Game game = Game.fromJson(games[i]['gameName']);
                    player.id = games[i]['playerId'];
                    game.id = games[i]['gameId'];
                    showLoaderDialog(context);
                    var check = await _db.checkGame(
                        games[i]['gameId'], games[i]['playerId']);
                    Navigator.pop(context);
                    if (check['exists']) {
                      if (check['isHost']) {
                        if (!check['isStarted']) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PublishedGame(game, player),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LiveScreen(game, player),
                            ),
                          );
                        }
                      } else {
                        if (check['isAllowed']) {
                          LiveScreen(game, player);
                        } else {
                          //TODO:correct
                          /*_prefs.removeGame(games[i]['gameId']).then((value) {
                            getCurrentGames();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Either the game is ended or you have been removed.',
                                ),
                              ),
                            );
                          });*/
                        }
                      }
                    } else {
                      /* _prefs.removeGame(games[i]['gameId']).then((value) {
                        getCurrentGames();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Either the game is ended or you have been removed.',
                            ),
                          ),
                        );
                      });*/
                    }
                  },
                ),
                Divider(
                  indent: 5,
                  endIndent: 5,
                  color: Colors.deepPurple,
                  height: 1,
                )
              ],
              mainAxisSize: MainAxisSize.min,
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.live_tv),
            label: 'Games',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'Host',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.link),
            label: 'Join',
          )
        ],
        onTap: (int selected) {
          switch (selected) {
            case 1:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateGame(),
                  ));
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JoinGame(),
                ),
              );
              break;
          }
        },
      ),*/