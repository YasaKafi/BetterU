class NutritionInformation {
  Profile? profile;
  DailyNutrition? dailyNutrition;

  NutritionInformation({this.profile, this.dailyNutrition});

  NutritionInformation.fromJson(Map<String, dynamic> json) {
    profile =
    json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    dailyNutrition = json['daily_nutrition'] != null
        ? new DailyNutrition.fromJson(json['daily_nutrition'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    if (this.dailyNutrition != null) {
      data['daily_nutrition'] = this.dailyNutrition!.toJson();
    }
    return data;
  }
}

class Profile {
  String? jenisKelamin;
  int? umur;
  double? beratBadan;
  double? tinggiBadan;
  String? tingkatAktivitas;
  String? tujuan;

  Profile(
      {this.jenisKelamin,
        this.umur,
        this.beratBadan,
        this.tinggiBadan,
        this.tingkatAktivitas,
        this.tujuan});

  Profile.fromJson(Map<String, dynamic> json) {
    jenisKelamin = json['Jenis Kelamin'];
    umur = json['Umur'];
    beratBadan = json['Berat Badan'];
    tinggiBadan = json['Tinggi Badan'];
    tingkatAktivitas = json['Tingkat Aktivitas'];
    tujuan = json['Tujuan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Jenis Kelamin'] = this.jenisKelamin;
    data['Umur'] = this.umur;
    data['Berat Badan'] = this.beratBadan;
    data['Tinggi Badan'] = this.tinggiBadan;
    data['Tingkat Aktivitas'] = this.tingkatAktivitas;
    data['Tujuan'] = this.tujuan;
    return data;
  }
}

class DailyNutrition {
  double? totalKalori;
  double? protein;
  double? lemak;
  double? karbohidrat;

  DailyNutrition(
      {this.totalKalori, this.protein, this.lemak, this.karbohidrat});

  DailyNutrition.fromJson(Map<String, dynamic> json) {
    totalKalori = json['Total Kalori'];
    protein = json['Protein'];
    lemak = json['Lemak'];
    karbohidrat = json['Karbohidrat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Total Kalori'] = this.totalKalori;
    data['Protein'] = this.protein;
    data['Lemak'] = this.lemak;
    data['Karbohidrat'] = this.karbohidrat;
    return data;
  }
}
