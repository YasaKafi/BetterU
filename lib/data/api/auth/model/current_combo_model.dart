class ShowCurrentCombo {
  List<DataCombo>? data;

  ShowCurrentCombo({this.data});

  ShowCurrentCombo.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DataCombo>[];
      json['data'].forEach((v) {
        data!.add(new DataCombo.fromJson(v));
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

class DataCombo {
  int? id;
  int? userId;
  String? category;
  String? name;
  String? note;
  int? kalori;
  dynamic lemak;
  dynamic protein;
  dynamic karbohidrat;
  String? date;
  String? createdAt;

  DataCombo(
      {this.id,
        this.userId,
        this.category,
        this.name,
        this.note,
        this.kalori,
        this.lemak,
        this.protein,
        this.karbohidrat,
        this.date,
        this.createdAt});

  DataCombo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    category = json['category'];
    name = json['name'];
    note = json['note'];
    kalori = json['kalori'];
    lemak = json['lemak'];
    protein = json['protein'];
    karbohidrat = json['karbohidrat'];
    date = json['date'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['category'] = this.category;
    data['name'] = this.name;
    data['note'] = this.note;
    data['kalori'] = this.kalori;
    data['lemak'] = this.lemak;
    data['protein'] = this.protein;
    data['karbohidrat'] = this.karbohidrat;
    data['date'] = this.date;
    data['created_at'] = this.createdAt;
    return data;
  }
}
