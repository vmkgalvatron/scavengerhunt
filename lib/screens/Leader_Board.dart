import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scavenger_hunt/models/game.dart';
import 'package:scavenger_hunt/models/player.dart';
import 'package:scavenger_hunt/services/database.dart';
import 'package:scavenger_hunt/widgets/player_score_widget.dart';

class LeaderBoard extends StatefulWidget {
  final Game game;
  Player player;
  LeaderBoard(this.game, this.player);
  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  Database _db = Database();
  Stream<QuerySnapshot> leaderBoardStream;
  getLeaderBoardStream() {
    setState(() {
      leaderBoardStream = _db.getLeaderBoard(widget.game.id);
    });
  }

  @override
  void initState() { 
    super.initState();
    getLeaderBoardStream();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: leaderBoardStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                var players = snapshot.data.docs;
                return Dismissible(
                  onDismissed: (x) async {
                    await _db.leaveGame(widget.game, players[index].id);
                  },
                  key: Key(players[index].id),
                  direction: widget.game.hostId == widget.player.id
                      ? widget.game.hostId==players[index].id? DismissDirection.none:
                      DismissDirection.endToStart
                      : DismissDirection.none,
                  child: PlayerScore(
                    player: snapshot.data.docs[index]['name'],
                    score: snapshot.data.docs[index]['score'],
                  ),
                );
              });
        });
  }
}
