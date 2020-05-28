class Todo {
  int id;
  String text;
  bool completed;

  Todo({this.id, this.text, this.completed});

  Todo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    completed = json['completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['completed'] = this.completed;
    return data;
  }
}