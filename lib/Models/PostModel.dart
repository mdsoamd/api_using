


class PostsModel {
  PostsModel({
      int? userId, 
      int? id, 
      String? title, 
      String? body,}){
    _userId = userId;
    _id = id;
    _title = title;
    _body = body;
}

  PostsModel.fromJson(dynamic json) {
    _userId = json['userId'];
    _id = json['id'];
    _title = json['title'];
    _body = json['body'];
  }
  int? _userId;
  int? _id;
  String? _title;
  String? _body;

  int? get userId => _userId;
  int? get id => _id;
  String? get title => _title;
  String? get body => _body;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = _userId;
    map['id'] = _id;
    map['title'] = _title;
    map['body'] = _body;
    return map;
  }

}







// class PostsModel {
//   int? userId;
//   int? id;
//   String? title;
//   String? body;

//   PostsModel({this.userId, this.id, this.title, this.body});

//   PostsModel.fromJson(Map<String, dynamic> json) {
//     userId = json['userId'];
//     id = json['id'];
//     title = json['title'];
//     body = json['body'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['userId'] = this.userId;
//     data['id'] = this.id;
//     data['title'] = this.title;
//     data['body'] = this.body;
//     return data;
//   }
// }