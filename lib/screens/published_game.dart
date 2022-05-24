import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scavenger_hunt/models/game.dart';
import 'package:scavenger_hunt/models/player.dart';
import 'package:scavenger_hunt/screens/live_game.dart';
import 'package:scavenger_hunt/services/database.dart';
import 'package:scavenger_hunt/widgets/loading_dialog.dart';
import 'package:share/share.dart';

class PublishedGame extends StatefulWidget {
  PublishedGame(this.game, this.player);
  Game game;
  Player player;

  @override
  _PublishedGameState createState() => _PublishedGameState();
}

class _PublishedGameState extends State<PublishedGame> {
  Database _db = Database();
  Stream<QuerySnapshot> playersStream;

  @override
  void initState() {
    super.initState();
    createStream();
  }

  void createStream() async {
    setState(() {
      playersStream = _db.getPlayers(widget.game.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.game.name),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          ListTile(
            tileColor: Colors.deepPurple[50],
            title: Text('Code- ${widget.game.joinCode}'),
            trailing: IconButton(
                icon: Icon(
                  Icons.share,
                  color: Colors.deepPurple[900],
                ),
                onPressed: () {
                  Share.share('Code- ${widget.game.joinCode}');
                }),
          ),
          ListTile(
            title: Text('Participants'),
          ),
          StreamBuilder(
            stream: playersStream,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              print(snapshot.connectionState);
              if (snapshot.hasData || snapshot.hasError) {
                var players = snapshot.data.docs;
                if (players.length == 1) {
                  return Container(
                    child: Text(
                        '''You currently have no participants share the code above with the participants and ask them to download the app, use the code to join the game.
After few participants have joined the game the start game option will be enabled.'''),
                    padding: EdgeInsets.all(20),
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, i) {
                      return Dismissible(
                        direction: players[i].id == widget.game.hostId
                            ? DismissDirection.none
                            : DismissDirection.endToStart,
                        key: Key(players[i].id),
                        child: ListTile(
                          title: Text(
                            players[i]['name'],
                          ),
                        ),
                        onDismissed: (x) async {
                          await _db.leaveGame(widget.game, players[i].id);
                        },
                      );
                    },
                  );
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
      bottomSheet: Row(
        children: [
          IconButton(
              icon: Icon(Icons.home, size: 35),
              onPressed: () {
                Navigator.pop(context);
              }),
          ElevatedButton(
            child: Text('Start Game'),
            onPressed: () async {
              showLoaderDialog(context);
              widget.game.isStarted = true;
              await _db.editGame(widget.game.id, {'isStarted': true});
              Navigator.pop(context);
              //pass widget.player
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LiveScreen(widget.game, widget.player),
                ),
              );
            },
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
    );
  }

  void onDismissed(String id) async {
    await _db.leaveGame(widget.game, id);
  }
}

class DismissiblePlayer extends StatelessWidget {
  DismissiblePlayer(this.name, this.index, this.onDismissed);
  String name;
  int index;
  Function onDismissed;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(name),
      child: Text(name),
      direction: DismissDirection.endToStart,
      onDismissed: (DismissDirection dismissDirection) async {
        await onDismissed(index);
      },
    );
  }
}
