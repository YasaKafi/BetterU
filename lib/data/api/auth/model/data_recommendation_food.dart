class RecommendationContent {
  final String? makananOne;
  final String? makananTwo;
  final String? makananThree;
  final String? makananFour;

  RecommendationContent({
    this.makananOne,
    this.makananTwo,
    this.makananThree,
    this.makananFour,
  });

  factory RecommendationContent.fromJson(Map<String, dynamic> json) {
    return RecommendationContent(
      makananOne: json['makanan_one'],
      makananTwo: json['makanan_two'],
      makananThree: json['makanan_three'],
      makananFour: json['makanan_four'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'makanan_one': makananOne,
      'makanan_two': makananTwo,
      'makanan_three': makananThree,
      'makanan_four': makananFour,
    };
  }
}
