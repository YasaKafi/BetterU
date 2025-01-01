class ShowCurrentUserResponse {
  DataUser? data;

  ShowCurrentUserResponse({this.data});

  ShowCurrentUserResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? DataUser.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DataUser {
  int? id;
  String? name;
  String? email;
  String? dateOfBirth;
  int? age; // Ubah tipe data ke int
  String? gender;
  String? goals;
  double? weight; // Ubah tipe data ke double
  double? height; // Ubah tipe data ke double
  String? activityLevel;

  DataUser({
    this.id,
    this.name,
    this.email,
    this.dateOfBirth,
    this.age,
    this.gender,
    this.goals,
    this.weight,
    this.height,
    this.activityLevel,
  });

  DataUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    dateOfBirth = json['date_of_birth'];
    age = json['age'] != null ? int.tryParse(json['age'].toString()) : null; // Konversi ke int
    gender = json['gender'];
    goals = json['goals'];
    weight = json['weight'] != null ? double.tryParse(json['weight'].toString()) : null; // Konversi ke double
    height = json['height'] != null ? double.tryParse(json['height'].toString()) : null; // Konversi ke double
    activityLevel = json['activity_level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['date_of_birth'] = this.dateOfBirth;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['goals'] = this.goals;
    data['weight'] = this.weight;
    data['height'] = this.height;
    data['activity_level'] = this.activityLevel;
    return data;
  }
}

