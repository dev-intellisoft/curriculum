
import 'package:curriculum/core/classes/education.dart';
import 'package:curriculum/core/classes/experience.dart';
import 'package:curriculum/core/classes/language.dart';
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
  List<Experience> experiences = <Experience>[];
  List<Education> educations = <Education>[];
  List<Language> languages = <Language>[];
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
    required this.experiences,
    required this.educations,
    required this.languages,
    this.skills
  });

  Resume.fromJson(Map<String, dynamic> json) {
    id = json['resume_id'];
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
        experiences.add(Experience.fromJson(v));
      });
    }
    if (json['educations'] != null) {
      educations = <Education>[];
      json['educations'].forEach((v) {
        educations.add(Education.fromJson(v));
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
    data['experiences'] = experiences.map((v) => v.toJson()).toList();
    data['educations'] = educations.map((v) => v.toJson()).toList();
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

  Map<String, dynamic> prepareStatement() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['resume_id'] = id;
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

