class Education {
  int? id;
  int? resumeId;
  String? course;
  String? institution;
  String? location;
  String? description;
  String? start;
  String? end;

  Education({
    this.id,
    this.resumeId,
    this.course,
    this.institution,
    this.description,
    this.location,
    this.start,
    this.end
  });

  Education.fromJson(Map<String, dynamic> json) {
    id = json['education_id'];
    course = json['course'];
    institution = json['institution'];
    description = json['description'];
    location = json['location'];
    start = json['start'];
    end = json['end'];
  }

  Map<String, dynamic> prepareStatement() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['education_id'] = id;
    data['resume_id'] = resumeId;
    data['course'] = course;
    data['institution'] = institution;
    data['location'] = location;
    data['description'] = description;
    data['start'] = start;
    data['end'] = end;
    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['course'] = course;
    data['institution'] = institution;
    data['location'] = location;
    data['description'] = description;
    data['start'] = start;
    data['end'] = end;
    return data;
  }
}
