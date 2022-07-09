import 'package:intl/intl.dart';

class Experience {
  int? id;
  int? tempId;
  int? resumeId;
  String? company;
  String? title;
  DateTime? start;
  DateTime? end;
  List<String>? keywords;
  String? description;
  String? location;

  Experience({
    this.id,
    this.tempId,
    this.resumeId,
    this.company,
    this.title,
    this.start,
    this.end,
    this.keywords,
    this.description,
    this.location
  });

  Experience.fromJson(Map<String, dynamic> json) {
    id = json['experience_id'];
    resumeId = json['resume_id'];
    company = json['company'];
    title = json['title'];
    if ( json['start'] != null ) {
      start = DateTime.parse(json['start']);
    }
    if ( json['end'] != null ) {
      end = DateTime.parse(json['end']);
    }
    // keywords = json['keywords'].cast<String>();
    description = json['description'];
    location = json['location'];
  }

  Map<String, dynamic> prepareStatement() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['experience_id'] = id;
    data['resume_id'] = resumeId;
    data['company'] = company;
    data['title'] = title;
    if ( start != null ) {
      data['start'] = DateFormat('yyyy-MM-dd').format(start!).toString();
    }
    if ( end != null ) {
      data['end'] = DateFormat('yyyy-MM-dd').format(end!).toString();
    }
    data['keywords'] = keywords;
    data['description'] = description;
    data['location'] = location;
    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['resume_id'] = resumeId;
    data['company'] = company;
    data['title'] = title;
    if ( start != null ) {
      data['start'] = DateFormat('yyyy-MM-dd').format(start!);
    }
    if ( end != null ) {
      data['end'] = DateFormat('yyyy-MM-dd').format(end!);
    }
    data['keywords'] = keywords;
    data['description'] = description;
    data['location'] = location;
    return data;
  }
}
