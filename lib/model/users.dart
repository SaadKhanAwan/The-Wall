class Users {
  String? username;
  String? bio;
  String? email;
  Users({this.username, this.bio, this.email});

  Users.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    bio = json['bio'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['bio'] = bio;
    data['email'] = email;
    return data;
  }
}
