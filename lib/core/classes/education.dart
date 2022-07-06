class Education {
  int? id;
  int? tempId;
  String? course;
  String? institution;
  String? start;
  String? end;

  Education({
    this.id,
    this.course,
    this.institution,
    this.start,
    this.end
  });

  Education.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    course = json['course'];
    institution = json['institution'];
    start = json['start'];
    end = json['end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['course'] = course;
    data['institution'] = institution;
    data['start'] = start;
    data['end'] = end;
    return data;
  }
}
