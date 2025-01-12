class SportModel {
  List<Data>? data;

  SportModel({this.data});

  SportModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? category;
  String? time;
  String? kalori;
  String? imageUrl;
  String? videoUrl;
  String? goals;

  Data(
      {this.id,
        this.name,
        this.category,
        this.time,
        this.kalori,
        this.imageUrl,
        this.videoUrl,
        this.goals});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
    time = json['time'];
    kalori = json['kalori'];
    imageUrl = json['imageUrl'];
    videoUrl = json['videoUrl'];
    goals = json['goals'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category'] = this.category;
    data['time'] = this.time;
    data['kalori'] = this.kalori;
    data['imageUrl'] = this.imageUrl;
    data['videoUrl'] = this.videoUrl;
    data['goals'] = this.goals;
    return data;
  }
}