class CurrentTotalNutrition {
  int? totalKaloriMakan;
  int? totalKaloriAktivitas;
  int? totalKaloriSekarang;
  int? totalLemak;
  int? totalProtein;
  int? totalKarbohidrat;

  CurrentTotalNutrition(
      {this.totalKaloriMakan,
        this.totalKaloriAktivitas,
        this.totalKaloriSekarang,
        this.totalLemak,
        this.totalProtein,
        this.totalKarbohidrat});

  CurrentTotalNutrition.fromJson(Map<String, dynamic> json) {
    totalKaloriMakan = json['total_kalori_makan'];
    totalKaloriAktivitas = json['total_kalori_aktivitas'];
    totalKaloriSekarang = json['total_kalori_sekarang'];
    totalLemak = json['total_lemak'];
    totalProtein = json['total_protein'];
    totalKarbohidrat = json['total_karbohidrat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_kalori_makan'] = this.totalKaloriMakan;
    data['total_kalori_aktivitas'] = this.totalKaloriAktivitas;
    data['total_kalori_sekarang'] = this.totalKaloriSekarang;
    data['total_lemak'] = this.totalLemak;
    data['total_protein'] = this.totalProtein;
    data['total_karbohidrat'] = this.totalKarbohidrat;
    return data;
  }
}
