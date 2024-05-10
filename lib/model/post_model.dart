import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String? id;
  String? email;
  String? post;
  Timestamp? timeStamp;
  List<String>? likes;

  Post({this.id, this.email, this.post, this.timeStamp, this.likes});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as String?,
      email: json['email'] as String?,
      post: json['post'] as String?,
      timeStamp: json['timeStamp'] is Timestamp
          ? json['timeStamp'] as Timestamp
          : null,
      likes: json['likes'] != null
          ? List<String>.from(json['likes'] as List)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['post'] = post;
    data['timeStamp'] = timeStamp;
    if (likes != null) {
      data['likes'] = likes!.map((v) => v).toList();
    }
    return data;
  }
}
