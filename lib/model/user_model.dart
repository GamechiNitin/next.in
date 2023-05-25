class UserResponse {
  List<UserModel>? results;

  UserResponse({this.results});

  UserResponse.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <UserModel>[];
      json['results'].forEach((v) {
        results!.add(UserModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserModel {
  String? name;
  String? email;
  String? password;
  String? oldpassword;
  bool? isUserLogIn;
  String? uuid;

  UserModel({
    this.name,
    this.email,
    this.password,
    this.isUserLogIn,
    this.oldpassword,
    this.uuid,
  });

  UserModel.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    email = json['email'].toString().toLowerCase();
    password = json['password'];
    uuid = json['uuid'];
    isUserLogIn = json['isUserLogIn'];
    oldpassword = json['oldpassword'];
  }

  Map<dynamic, dynamic> toJson() {
    Map<dynamic, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["email"] = email.toString().toLowerCase();
    data["password"] = password;
    data["isUserLogIn"] = isUserLogIn;
    data["oldpassword"] = oldpassword;
    data["uuid"] = uuid;
    return data;
  }
}
