class Language {
  int? id;
  int? resumeId;
  String? language;
  String? level;

  Language({
    this.id,
    this.resumeId,
    this.language,
    this.level
  });

  Map<String, dynamic> toJson () {
    return {
      'id': id,
      'resume_id': resumeId,
      'language': language,
      'level': level
    };
  }

  Language.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    resumeId = json['resume_id'];
    language = json['language'];
    level = json['level'];
  }

  Map<String, dynamic> prepareStatement() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    // data['language_id'] = id;
    data['id'] = id;
    data['resume_id'] = resumeId;
    data['language'] = language;
    data['level'] = level;
    return data;
  }
}
