class Activity {
  Activity(this.title);

  String id;
  String title;
  bool done = false;

  Activity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    done = json['done'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = Map<String, dynamic>();
    json['title'] = this.title;
    json['done'] = this.done;
    return json;
  }
}
