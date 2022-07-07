import 'package:flutter/cupertino.dart';
import 'package:curriculum/core/classes/resume.dart';
import 'package:curriculum/core/classes/experience.dart';
import 'package:curriculum/core/classes/education.dart';

import '../database_helper.dart';

class ResumeProvider with ChangeNotifier {
  Resume resume = Resume(experiences: [], educations: []);
  List<Resume> resumes = [];

  Future<List<Resume>> loadResumes() async {
    List<Resume> resumes = [];
    List<dynamic> data = await DatabaseHelper.instance.getResumes();

    for ( int i = 0; i <  data.length; i ++ ) {
      resumes.add(Resume.fromJson(data[i]));
    }
    return resumes;
  }

  void setResume(Resume _resume) {
    resume = _resume;
    notifyListeners();
  }

  List<Resume> getResumes() {
    return resumes;
  }

  Resume getResume() {
    return resume;
  }

  void saveResume(Resume resume) async {
    if ( resume.name == null ) {
      return;
    }
    if ( resume.id != null && resume.id! > 0) {
      await DatabaseHelper.instance.updateResume(resume);
    } else {
      int resumeId = await DatabaseHelper.instance.saveResume(resume);
      resume.id = resumeId;
    }
    resume = resume;
    notifyListeners();
  }

  void removeResume (int resumeId) async {
    await DatabaseHelper.instance.removeResume(resumeId);
    notifyListeners();
  }

  void saveExperience(Experience experience) async {
    if ( experience.company == null || experience.company == '' ) {
      return;
    }

    if ( experience.id == null ) {
      experience.resumeId = resume.id;
      await DatabaseHelper.instance.insertExperience(experience);
    } else {
      await DatabaseHelper.instance.updateExperience(experience);
    }

    resume.experiences = await DatabaseHelper.instance.getExperiences(resume.id!);

    notifyListeners();
  }

  void removeExperience(int index) {
    resume.experiences.removeAt(index);
    notifyListeners();
  }

  void saveEducation(Education education) {
    if ( education.tempId == null ) {
      education.tempId = resume.educations!.length;
      resume.educations!.add(education);
    } else {
      resume.educations![education.tempId!] = education;
    }
    notifyListeners();
  }

  void removeEducation(int index) {
    resume.educations!.removeAt(index);
    notifyListeners();
  }

  List<Education>? getEducations() {
    return resume.educations ?? [];
  }

  List<Experience>? getExperience () {
    return resume.experiences;
  }
}
