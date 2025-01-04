class ShowPrediction {
  String? prediction;

  ShowPrediction({this.prediction});

  ShowPrediction.fromJson(Map<String, dynamic> json) {
    prediction = json['prediction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prediction'] = this.prediction;
    return data;
  }
}
