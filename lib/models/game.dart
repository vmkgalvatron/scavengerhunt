class Game {
  Game(this.name, this.joinCode);

  String id;
  String name;
  String hostId;
  String joinCode;
  bool isStarted = false;
  int playerCount = 1;

  Game.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    hostId = json['hostId'];
    joinCode = json['joinCode'];
    isStarted = json['isStarted'];
    playerCount = json['playerCount'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = Map<String, dynamic>();
    json['name'] = this.name;
    json['playerCount'] = this.playerCount;
    json['joinCode'] = this.joinCode;
    json['isStarted'] = this.isStarted;
    if (this.hostId != null) {
      json['hostId'] = this.hostId;
    }
    return json;
  }
}
