import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scavenger_hunt/models/game.dart';
import 'package:scavenger_hunt/models/player.dart';
import 'package:scavenger_hunt/screens/activity_screen.dart';
import 'package:scavenger_hunt/services/database.dart';
import 'package:scavenger_hunt/widgets/removed_dialog.dart';
import 'game_feed.dart';
import 'leader_board.dart';

class LiveScreen extends StatefulWidget {
  LiveScreen(this.game, this.player);
  final Player player;
  final Game game;

  @override
  _LiveScreenState createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  var playerStream;
  Database _db = Database();

  @override
  void initState() {
    super.initState();
    isRemovedFunction();
  }

  @override
  void dispose() {
    super.dispose();
  }

  isRemovedFunction() async {
    playerStream = await FirebaseFirestore.instance
        .collection('Games')
        .doc(widget.game.id)
        .collection('players')
        .doc(widget.player.id)
        .snapshots()
        .listen((event) {
      if (!event.exists) {
        showPlayerRemovedDialog(context).then((value) {
          Navigator.pop(context);
        });
      }
    });
  }

  getPlayerStream() async {
    await FirebaseFirestore.instance
        .collection('Games')
        .doc(widget.game.id)
        .collection('players');
    //TODO: Check Player Exists.
    setState(() {
      playerStream = _db.getPlayers(widget.game.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.game.name),
          automaticallyImplyLeading: false,
        ),
        body: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              Container(
                constraints: BoxConstraints.expand(height: 50),
                child: TabBar(
                  isScrollable: false,
                  labelColor: Colors.black,
                  tabs: [
                    Tab(
                      text: 'Activity',
                    ),
                    Tab(
                      text: 'Leaderboard',
                    ),
                    Tab(
                      text: 'Game Feed',
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: TabBarView(children: [
                    ActivityScreen(widget.game, widget.player),
                    LeaderBoard(widget.game, widget.player),
                    GameFeed(widget.game, widget.player),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          widget.player.id == widget.game.hostId
                              ? endGame()
                              : leaveGame();
                          showPlayerRemovedDialog(context).then((value) {
                            Navigator.pop(context);
                          });
                        },
                        child: Text(
                          widget.player.id == widget.game.hostId
                              ? "End Game"
                              : "Leave Game",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xff6200EE))))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  endGame() {
    Database _db = Database();
    _db.endGame(widget.game.id);
  }

  leaveGame() {
    Database _db = Database();
    _db.leaveGame(widget.game, widget.player.id);
  }
}
