class ShowCurrentUserResponse {
  DataUser? data;

  ShowCurrentUserResponse({this.data});

  ShowCurrentUserResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new DataUser.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DataUser {
  int? id;
  String? email;
  String? name;
  String? avatar;
  String? gender;
  String? role;

  DataUser({this.id, this.email, this.name, this.avatar, this.gender, this.role});

  DataUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    avatar = json['avatar'];
    gender = json['gender'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['gender'] = this.gender;
    data['role'] = this.role;
    return data;
  }
}
