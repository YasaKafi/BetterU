class CurrentDailyWater {
  Data? data;

  CurrentDailyWater({this.data});

  CurrentDailyWater.fromJson(Map<String, dynamic> json) {
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
  String? amount;
  int? totalGlasses;
  String? date;

  Data({this.amount, this.totalGlasses, this.date});

  Data.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    totalGlasses = json['total_glasses'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['total_glasses'] = this.totalGlasses;
    data['date'] = this.date;
    return data;
  }
}
