import 'package:flutter/cupertino.dart';
import 'package:curriculum/core/classes/resume.dart';
import 'package:curriculum/core/classes/experience.dart';
import 'package:curriculum/core/classes/education.dart';

import '../database_helper.dart';

class ResumeProvider with ChangeNotifier {
  Resume resume = Resume(experiences: [], educations: []);

  Resume getResume() {
    return resume;
  }

  void saveExperience(Experience experience) {
    if ( experience.tempId == null ) {
      experience.tempId = resume.experiences!.length;
      resume.experiences!.add(experience);
    } else {
      resume.experiences![experience.tempId!] = experience;
    }
    notifyListeners();
  }

  void removeExperience(int index) {
    resume.experiences!.removeAt(index);
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
    return resume.experiences ?? [];
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
}
