import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String? commentText;
  String? commentBy;
  Timestamp? timeStamp;

  Comment({
    this.commentText,
    this.commentBy,
    this.timeStamp,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      commentText: json['id'] as String?,
      commentBy: json['email'] as String?,
      timeStamp: json['timeStamp'] is Timestamp
          ? json['timeStamp'] as Timestamp
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = commentText;
    data['email'] = commentBy;
    data['timeStamp'] = timeStamp;

    return data;
  }
}
