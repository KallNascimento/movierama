class SpokenLanguageModel {
  String iso6391;
  String englishName;
  String name;

  SpokenLanguageModel({this.iso6391, this.englishName, this.name});

  SpokenLanguageModel.fromJson(Map<String, dynamic> json) {
    iso6391 = json['iso_639_1'];
    englishName = json['english_name'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iso_639_1'] = this.iso6391;
    data['english_name'] = this.englishName;
    data['name'] = this.name;
    return data;
  }
}
