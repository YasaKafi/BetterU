class Food {
  List<Data>? data;

  Food({this.data});

  Food.fromJson(Map<String, dynamic> json) {
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
    protein = json['protein'];
    lemak = json['lemak'];
    karbohidrat = json['karbohidrat'];
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