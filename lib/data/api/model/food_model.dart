class FoodModel {
  Data? data;

  FoodModel({this.data});

  FoodModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  int? kalori;
  double? protein;
  double? lemak;
  double? karbohidrat;
  String? note;
  String? imageUrl;
  String? videoUrl;
  int? time;
  String? goals;
  int? clickCount;

  Data(
      {this.id,
        this.name,
        this.kalori,
        this.protein,
        this.lemak,
        this.karbohidrat,
        this.note,
        this.imageUrl,
        this.videoUrl,
        this.time,
        this.goals,
        this.clickCount});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    kalori = json['kalori'];
    protein = (json['protein'] as num?)?.toDouble();
    lemak = (json['lemak'] as num?)?.toDouble();
    karbohidrat = (json['karbohidrat'] as num?)?.toDouble();
    note = json['note'];
    imageUrl = json['imageUrl'];
    videoUrl = json['videoUrl'];
    time = json['time'];
    goals = json['goals'];
    clickCount = json['click_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['kalori'] = this.kalori;
    data['protein'] = this.protein;
    data['lemak'] = this.lemak;
    data['karbohidrat'] = this.karbohidrat;
    data['note'] = this.note;
    data['imageUrl'] = this.imageUrl;
    data['videoUrl'] = this.videoUrl;
    data['time'] = this.time;
    data['goals'] = this.goals;
    data['click_count'] = this.clickCount;
    return data;
  }
}
