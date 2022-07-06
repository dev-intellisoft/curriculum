import 'package:flutter/cupertino.dart';
import 'package:curriculum/core/classes/resume.dart' as r;
import 'package:curriculum/core/classes/experience.dart';
import 'package:curriculum/core/classes/education.dart';

class ResumeProvider with ChangeNotifier {
  r.Resume resume = r.Resume(experiences: [], education: []);

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
      education.tempId = resume.education!.length;
      resume.education!.add(education);
    } else {
      resume.education![education.tempId!] = education;
    }
    notifyListeners();
  }

  List<Education>? get getEducations => resume.education;
  List<Experience>? getExperience () {
    return resume.experiences ?? [];
  }
}
