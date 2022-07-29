import 'package:flutter/cupertino.dart';
import 'package:curriculum/core/classes/resume.dart';
import 'package:curriculum/core/classes/experience.dart';
import 'package:curriculum/core/classes/education.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../classes/language.dart';
import '../database_helper.dart';

class ResumeProvider with ChangeNotifier {
  Resume resume = Resume(experiences: [], educations: [], languages: []);
  List<Resume> resumes = [];

  Future<List<Resume>> loadResumes() async {
    List<Resume> resumes = await DatabaseHelper.instance.getResumes();
    return resumes;
  }

  void setResume(Resume _resume) async {
    resume = _resume;
    resume.languages = await DatabaseHelper.instance.getAllLanguagesFromByResumeId(resume.id!);
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
    await DatabaseHelper.instance.removeLanguagesFromResume(resume.id!);

    resume.languages.forEach((language) async {
      language.resumeId = resume.id;
      await DatabaseHelper.instance.insertLanguages(language);
    });

    resume = resume;
    resume.languages = await DatabaseHelper.instance.getAllLanguagesFromByResumeId(resume.id!);
    notifyListeners();
  }

  void removeResume (int resumeId) async {
    await DatabaseHelper.instance.removeLanguagesFromResume(resumeId);
    await DatabaseHelper.instance.removeResume(resumeId);
    notifyListeners();
  }

  addLanguage(Language language) {
    resume.languages.add(language);
    notifyListeners();
  }

  updateLanguageAt(int index, Language language) {
    resume.languages[index] = language;
    notifyListeners();
  }

  removeLanguageAt(int index) {
    resume.languages.removeAt(index);
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

  void removeExperience(int experienceId) async {
    await DatabaseHelper.instance.removeExperience(experienceId);
    resume.experiences = await DatabaseHelper.instance.getExperiences(resume.id!);
    notifyListeners();
  }

  Future loadExperiences () async {
    resume.experiences = await DatabaseHelper.instance.getExperiences(resume.id!);
  }

  List<Experience>? getExperience () {
    return resume.experiences;
  }

  void saveEducation(Education education) async {
    if ( education.institution == null || education.institution == '' ) {
      return;
    }

    if ( education.id == null ) {
      education.resumeId = resume.id;
      await DatabaseHelper.instance.insertEducation(education);
    } else {
      await DatabaseHelper.instance.updateEducation(education);
    }

    resume.educations = await DatabaseHelper.instance.getEducations(resume.id!);

    notifyListeners();
  }

  void removeEducation(int educationId) async {
    await DatabaseHelper.instance.removeEducation(educationId);
    resume.educations = await DatabaseHelper.instance.getEducations(resume.id!);
    notifyListeners();
  }

  Future loadEducations () async {
    resume.educations = await DatabaseHelper.instance.getEducations(resume.id!);
  }

  List<Education>? getEducations () {
    return resume.educations;
  }

  Future<void> cloneResume(resumeId, cloneName) async  {
    Resume resume = await DatabaseHelper.instance.getResume(resumeId);
    resume.educations = await DatabaseHelper.instance.getEducations(resumeId);
    resume.experiences = await DatabaseHelper.instance.getExperiences(resumeId);
    resume.languages = await DatabaseHelper.instance.getAllLanguagesFromByResumeId(resumeId);

    resume.name = cloneName;
    resume.id =  null;
    resume.id = await DatabaseHelper.instance.saveResume(resume);
    resume.educations.forEach((education) async {
      education.id = null;
      education.resumeId = resume.id;
      education.id = await DatabaseHelper.instance.insertEducation(education);
    });
    resume.experiences.forEach((experience) async {
      experience.id = null;
      experience.resumeId = resume.id;
      experience.id = await DatabaseHelper.instance.insertExperience(experience);
    });

    resume.languages.forEach((language) async {
      language.id = null;
      language.resumeId = resume.id;
      language.id = await DatabaseHelper.instance.insertLanguages(language);
    });

    resumes.add(resume);
    notifyListeners();
  }

  Future<bool> removeAccount() async {
    try {
      bool dbRemove = await DatabaseHelper.instance.removeAccount();
      if ( !dbRemove ) {
        return false;
      }
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      await _prefs.clear();
      return true;
    } catch (e){
      return false;
    }
  }

}
