import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scavenger_hunt/models/game.dart';
import 'package:scavenger_hunt/models/player.dart';
import 'package:scavenger_hunt/services/database.dart';
import 'package:scavenger_hunt/widgets/feed_widget.dart';

class GameFeed extends StatefulWidget {
  Game game;
  Player player;
  GameFeed(this.game, this.player);
  @override
  _GameFeedState createState() => _GameFeedState();
}

class _GameFeedState extends State<GameFeed> {
  Timer _everyMinuite;
  Stream<QuerySnapshot> gameFeedStream;
  var playerStream;
  Database _db = Database();
  getGameFeedStream() {
    setState(() {
      gameFeedStream = _db.getPosts(widget.game.id);
    });
  }

  @override
  void dispose() {
    _everyMinuite.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getGameFeedStream();
    _everyMinuite = Timer.periodic(Duration(minutes: 1), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: gameFeedStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                return Feeds(
                  playerId: widget.player.id,
                  hostId: widget.game.hostId,
                  caption: snapshot.data.docs[index]['caption'],
                  image: snapshot.data.docs[index]['image'],
                  player: snapshot.data.docs[index]['playerName'],
                  time: snapshot.data.docs[index]['uploadTime'],
                  postId: snapshot.data.docs[index].id,
                  postPlayerId: snapshot.data.docs[index]['playerId'],
                  gameId: widget.game.id,
                  status: snapshot.data.docs[index]['status'],
                );
              });
        });
  }
}
