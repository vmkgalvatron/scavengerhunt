import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scavenger_hunt/constants.dart';
import 'package:scavenger_hunt/models/activity.dart';
import 'package:scavenger_hunt/models/game.dart';
import 'package:scavenger_hunt/models/player.dart';
import 'package:scavenger_hunt/models/post.dart';

class Database {
  static final Database _singleton = Database._();

  Database._();

  factory Database() => _singleton;

  static Database get instance => _singleton;

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<Game> createGame(
      Game game, String hostName, List<Activity> activities) async {
    Player player = Player(hostName);
    final document = await _db.collection('Games').add(game.toJson());
    Game newGame = await document
        .collection('players')
        .add(player.toJson())
        .then((value) async {
      game.hostId = value.id;
      game.id = document.id;
      Map<String, dynamic> map = {
        'hostId': value.id,
      };
      await editGame(game.id, map);
      await addActivities(document.id, activities);
      return game;
    });

    return newGame;
  }

  Future<Map<String, dynamic>> joinGame(String code, Player player) async {
    Map<String, dynamic> resultMap = Map<String, dynamic>();
    var document;
    await _db
        .collection('Games')
        .where('joinCode', isEqualTo: code)
        .orderBy('playerCount')
        .limit(1)
        .get()
        .then((collectionref) async {
      if (collectionref.size == 0) {
        resultMap['result'] = 0;
      } else if (collectionref.docs.first.data()['playerCount'] >= maxPlayers) {
        resultMap['result'] = 1;
      } else {
        resultMap['result'] = 3;
        String gameId = collectionref.docs.first.id;
        Game game = Game.fromJson(collectionref.docs.first.data());
        game.id = gameId;
        resultMap['game'] = game.toJson();
        resultMap['gameId'] = game.id;
        Map<String, dynamic> map = {'playerCount': game.playerCount += 1};
        await editGame(game.id, map);
        document = await _db
            .doc('Games/$gameId')
            .collection('players')
            .add(player.toJson());
        resultMap['playerId'] = document.id;
      }
    });
    return resultMap;
  }

  Future<void> updateGame(String gameId, Game game) async {
    await _db.collection('Games').doc(gameId).update(game.toJson());
  }

  Future<void> leaveGame(Game game, String playerId) async {
    await _db
        .collection('Games')
        .doc(game.id)
        .collection('players')
        .doc(playerId)
        .delete();
    await _db
        .doc('Games/${game.id}')
        .update({'playerCount': game.playerCount - 1});
  }

  Future<void> updateScore(String gameId, String playerId) async {
    var data = await _db
        .doc('Games/$gameId')
        .collection('players')
        .doc(playerId)
        .get();
    await _db
        .doc('Games/$gameId')
        .collection('players')
        .doc(playerId)
        .update({'score': data['score'] + 1});
  }

  Future<void> endGame(String gameId) async {
    await _db.collection('Games').doc(gameId).delete();
  }

  Future<void> editGame(String gameId, Map<String, dynamic> map) async {
    await _db.collection('Games').doc(gameId).update(map);
  }

  Future<Map<String, bool>> checkGame(String gameId, String playerId) async {
    Map<String, bool> result = Map<String, bool>();
    await _db.doc("Games/$gameId").get().then((doc) async {
      result['exists'] = doc.exists;
      if (doc.exists) {
        result['isHost'] = doc['hostId'] == playerId;
        result['isStarted'] = doc['isStarted'];
        if (!result['isHost']) {
          var res = await _db
              .doc('Games/$gameId')
              .collection('players')
              .doc(playerId)
              .get();
          result['isAllowed'] = res.exists;
        }
      }
    });
    return result;
  }

  Stream<QuerySnapshot> getPlayers(String gameId) {
    return _db
        .collection('Games')
        .doc(gameId)
        .collection('players')
        .snapshots();
  }

  Future<void> addActivities(String gameId, List<Activity> activities) async {
    WriteBatch batch = _db.batch();
    CollectionReference collection =
        FirebaseFirestore.instance.collection('Games/$gameId/activities');
    for (final activity in activities) {
      batch.set(collection.doc(), activity.toJson());
    }
    batch.commit();
    print("success");
  }

  Future<void> editActivity(String gameId, Activity activity) async {
    await _db
        .doc('Games/$gameId')
        .collection('activities')
        .doc(activity.id)
        .update({'done': activity.done, 'title': activity.title});
  }

  Future<String> postActivity(String gameId, Post post) async {
    final document = await _db
        .collection('Games')
        .doc(gameId)
        .collection('posts')
        .add(post.toJson());
    return document.id;
  }

  Stream<QuerySnapshot> getActivities(String gameId) {
    return _db
        .collection('Games')
        .doc(gameId)
        .collection('activities')
        .snapshots();
  }

  Stream<QuerySnapshot> getPosts(String gameId) {
    return _db.collection('Games').doc(gameId).collection('posts').snapshots();
  }

  Stream<QuerySnapshot> getLeaderBoard(String gameId) {
    return _db
        .collection('Games')
        .doc(gameId)
        .collection('players')
        .snapshots();
  }

  Future<bool> changeStatus(bool correct, String gameId, String postId,
      {String playerId}) async {
    if (correct) {
      await updateScore(gameId, playerId);
    }
    await _db
        .collection('Games')
        .doc(gameId)
        .collection('posts')
        .doc(postId)
        .update({"status": false});
    return true;
  }
}
