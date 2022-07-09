import 'package:intl/intl.dart';

class Education {
  int? id;
  int? resumeId;
  String? course;
  String? institution;
  String? location;
  String? description;
  DateTime? start;
  DateTime? end;

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
    resumeId = json['resume_id'];
    course = json['course'];
    institution = json['institution'];
    description = json['description'];
    location = json['location'];
    if ( json['start'] != null ) {
      start = DateTime.parse(json['start']);
    }
    if ( json['end'] != null ) {
      end = DateTime.parse(json['end']);
    }
  }

  Map<String, dynamic> prepareStatement() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['education_id'] = id;
    data['resume_id'] = resumeId;
    data['course'] = course;
    data['institution'] = institution;
    data['location'] = location;
    data['description'] = description;
    if ( start != null ) {
      data['start'] = DateFormat('yyyy-MM-dd').format(start!);
    }
    if ( end != null ) {
      data['end'] = DateFormat('yyyy-MM-dd').format(end!);
    }
    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['resume_id'] = resumeId;
    data['course'] = course;
    data['institution'] = institution;
    data['location'] = location;
    data['description'] = description;
    if ( start != null ) {
      data['start'] = DateFormat('yyyy-MM-dd').format(start!);
    }
    if ( end != null ) {
      data['end'] = DateFormat('yyyy-MM-dd').format(end!);
    }
    return data;
  }
}
