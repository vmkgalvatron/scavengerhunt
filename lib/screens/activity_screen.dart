import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scavenger_hunt/models/game.dart';
import 'package:scavenger_hunt/models/player.dart';
import 'package:scavenger_hunt/screens/complete_activity.dart';
import 'package:scavenger_hunt/services/database.dart';
import 'package:scavenger_hunt/widgets/activity_widget.dart';

class ActivityScreen extends StatefulWidget {
  Game game;
  Player player;
  ActivityScreen(this.game, this.player);
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  Database _db = Database();
  @override
  void initState() {
    super.initState();
    print(widget.game.id);
    getActivityStream();
  }

  Stream<QuerySnapshot> activityStream;
  getActivityStream() {
    setState(() {
      activityStream = _db.getActivities(widget.game.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: activityStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData || snapshot.hasError) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              return TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (contet) => CompleteActivity(
                              snapshot.data.docs[index].id,
                              snapshot.data.docs[index]['title'],
                              widget.game,
                              widget.player)));
                },
                child: ActivityWidget(
                  activity: snapshot.data.docs[index]['title'],
                ),
              );
            });
      },
    );
  }
}
