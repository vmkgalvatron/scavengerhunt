import 'package:flutter/material.dart';

class PlayerScore extends StatelessWidget {
  PlayerScore({this.player,this.score});
  final String player;
  final int score;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints.expand(height: 50),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text(player),
              Text(score.toString())
            ],),
          ),
          
        ),
        SizedBox(child: Divider(height: 0.5,color: Colors.deepPurple,),),
        
      ],
    );
  }
}
