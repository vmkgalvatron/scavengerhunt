class Post {
  String id;
  String activityId;
  String image;
  String caption;
  String playerName;
  String uploadTime;
  String playerId;
  bool status = true;

  Post(this.activityId, this.image, this.caption, this.playerName,
      this.uploadTime, this.playerId);

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    activityId = json['activityId'];
    image = json['image'];
    caption = json['caption'];
    playerName = json['playerName'];
    uploadTime = json['uploadTime'];
    playerId = json['playerID'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = Map<String, dynamic>();
    json['image'] = this.image;
    json['caption'] = this.caption;
    json['activityId'] = this.activityId;
    json['playerName'] = this.playerName;
    json['uploadTime'] = this.uploadTime;
    json['playerId'] = this.playerId;
    json['status'] = this.status;
    return json;
  }
}
