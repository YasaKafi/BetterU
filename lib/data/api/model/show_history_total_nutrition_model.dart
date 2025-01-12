class ShowHistoryTotalNutrition {
  String? id; // ID Hardcoded
  String? date;
  int? totalKaloriMakan;
  int? totalKaloriAktivitas;
  int? totalKaloriSekarang;
  int? totalLemak;
  int? totalProtein;
  int? totalKarbohidrat;

  ShowHistoryTotalNutrition({
    this.id,
    this.date,
    this.totalKaloriMakan,
    this.totalKaloriAktivitas,
    this.totalKaloriSekarang,
    this.totalLemak,
    this.totalProtein,
    this.totalKarbohidrat,
  });

  ShowHistoryTotalNutrition.fromJson(Map<String, dynamic> json) {
    id = generateId(); // Hardcode ID saat parsing JSON
    date = json['date'];
    totalKaloriMakan = json['total_kalori_makan'];
    totalKaloriAktivitas = json['total_kalori_aktivitas'];
    totalKaloriSekarang = json['total_kalori_sekarang'];
    totalLemak = json['total_lemak'];
    totalProtein = json['total_protein'];
    totalKarbohidrat = json['total_karbohidrat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id; // Tambahkan ID ke JSON
    data['date'] = date;
    data['total_kalori_makan'] = totalKaloriMakan;
    data['total_kalori_aktivitas'] = totalKaloriAktivitas;
    data['total_kalori_sekarang'] = totalKaloriSekarang;
    data['total_lemak'] = totalLemak;
    data['total_protein'] = totalProtein;
    data['total_karbohidrat'] = totalKarbohidrat;
    return data;
  }

  // Generate Hardcoded ID (misalnya, gunakan kombinasi waktu atau indeks tetap)
  String generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}
