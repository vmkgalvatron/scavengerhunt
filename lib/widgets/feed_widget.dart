import 'package:flutter/material.dart';

import '../services/database.dart';

class Feeds extends StatelessWidget {
  Feeds(
      {this.player,
      this.time,
      this.caption,
      this.image,
      this.status,
      this.hostId,
      this.playerId,
      this.onDecision,
      this.postId,
      this.gameId,
      this.postPlayerId});
  final String player;
  final String time;
  final String image;
  final String caption;
  final String hostId;
  final String playerId;
  final Function onDecision;
  final String postId;
  final String gameId;
  final bool status;
  final String postPlayerId;
  DateTime currentTime = DateTime.now();
  Database _db = Database();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$player (Posted ${currentTime.difference(DateTime.parse(time)).inMinutes} mins ago)',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(image), fit: BoxFit.fill),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(caption),
            hostId == playerId && status
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        MaterialButton(
                          child: Text("Right"),
                          onPressed: () {
                            _db.changeStatus(true, gameId, postId,
                                playerId: postPlayerId);
                          },
                          color: Colors.green,
                          textColor: Colors.white,
                        ),
                        MaterialButton(
                          child: Text("Wrong"),
                          onPressed: () {
                            _db.changeStatus(false, gameId, postId);
                          },
                          color: Colors.red,
                          textColor: Colors.white,
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
