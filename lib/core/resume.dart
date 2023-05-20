import 'package:curriculum/core/classes/resume.dart';
import 'package:curriculum/core/common.dart';
import 'package:get/get.dart';
import '../screens/navigation.dart';
import 'database_helper.dart';

class ResumeController extends GetxController {
  DatabaseHelper db;
  ResumeController({required this.db});
  RxList resumes = [].obs;
  Rx<Resume> resume = Resume(experiences: [], educations: [], languages: []).obs;

  Future<void> loadResumes() async {
    resumes.value = await db.getResumes();
  }

  gotToResume(int index) async {
      resume.value = resumes[index];
      Get.to(() => const NavigationScreen());
  }

  cloneResume(int resumeId, String cloneName) async {
    if (cloneName == '') {
      showErrorMessage('Please type the clone name!');
      return;
    }

    Resume resume = await db.getResume(resumeId);
    resume.educations = await db.getEducations(resumeId);
    resume.experiences = await db.getExperiences(resumeId);
    resume.languages = await db.getAllLanguagesFromByResumeId(resumeId);

    resume.name = cloneName;
    resume.id =  null;
    resume.id = await db.saveResume(resume);
    resume.educations.forEach((education) async {
      education.id = null;
      education.resumeId = resume.id;
      education.id = await db.insertEducation(education);
    });
    resume.experiences.forEach((experience) async {
      experience.id = null;
      experience.resumeId = resume.id;
      experience.id = await db.insertExperience(experience);
    });

    resume.languages.forEach((language) async {
      language.id = null;
      language.resumeId = resume.id;
      language.id = await db.insertLanguages(language);
    });

    resumes.add(resume);
    Get.back();
    showSuccessMessage('Resume cloned!');
  }
}
