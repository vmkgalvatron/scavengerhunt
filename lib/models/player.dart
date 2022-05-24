class Player {
  String id;
  int score = 0;
  String name;

  Player(this.name);

  Player.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    score = json['score'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = Map<String, dynamic>();
    json['score'] = this.score;
    json['name'] = this.name;
    return json;
  }
}
