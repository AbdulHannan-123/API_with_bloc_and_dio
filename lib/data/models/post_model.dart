class PostModel {
  String? name;
  int? id;
  String? consistency;
  String? original;

  PostModel({this.name, this.id, this.consistency, this.original});

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    consistency = json['consistency'];
    original = json['original'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['consistency'] = this.consistency;
    data['original'] = this.original;
    return data;
  }
}