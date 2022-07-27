class Language {
  int? id;
  int? resumeId;
  String? language;
  String? level;

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
}
