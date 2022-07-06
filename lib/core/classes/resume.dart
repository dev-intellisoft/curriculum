
import 'package:curriculum/core/classes/education.dart';
import 'package:curriculum/core/classes/experience.dart';
import 'package:curriculum/core/database_helper.dart';

class Resume {
  int? id;
  String? name;
  String? firstName;
  String? lastName;
  String? telephone;
  String? email;
  String? location;
  String? linkedIn;
  String? github;
  List<Experience>? experiences;
  List<Education>? educations;
  List<String>? languages;
  List<String>? skills;

  Resume({
    this.id,
    this.name,
    this.firstName,
    this.lastName,
    this.telephone,
    this.email,
    this.location,
    this.linkedIn,
    this.github,
    this.experiences,
    this.educations,
    this.languages,
    this.skills
  });

  Resume.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    telephone = json['telephone'];
    email = json['email'];
    location = json['location'];
    linkedIn = json['linked_in'];
    github = json['github'];

    if (json['experiences'] != null) {
      experiences = <Experience>[];
      json['experiences'].forEach((v) {
        experiences!.add(Experience.fromJson(v));
      });
    }
    if (json['educations'] != null) {
      educations = <Education>[];
      json['educations'].forEach((v) {
        educations!.add(Education.fromJson(v));
      });
    }
    if ( json['languages'] != null ) {
      languages = json['languages'].cast<String>();
    }
    if (json['skills'] != null) {
      skills = json['skills'].cast<String>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['telephone'] = telephone;
    data['email'] = email;
    data['location'] = location;
    data['linked_in'] = linkedIn;
    data['github'] = github;

    if (experiences != null) {
      data['experiences'] = experiences!.map((v) => v.toJson()).toList();
    }
    if (educations != null) {
      data['educations'] = educations!.map((v) => v.toJson()).toList();
    }
    data['languages'] = languages;
    data['skills'] = skills;
    return data;
  }

  static Future<List<Resume>> getResumes() async {
    List<Resume> resumes = [];
     List<dynamic> data = await DatabaseHelper.instance.getResumes();
     for ( int i = 0; i <  data.length; i ++ ) {
       resumes.add(Resume.fromJson(data[i]));
     }
    return resumes;
  }

  Future<dynamic> save() async {
    try {
      var data = await DatabaseHelper.instance.saveResume(this);
      print(data);
    } catch (e) {
      print(e);
    }
  }


  Map<String, dynamic> prepareInsert() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['telephone'] = telephone;
    data['email'] = email;
    data['location'] = location;
    data['linked_in'] = linkedIn;
    data['github'] = github;
    return data;
  }
}

