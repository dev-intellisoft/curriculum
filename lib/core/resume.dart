import 'package:curriculum/core/classes/resume.dart';
import 'package:get/get.dart';

import 'database_helper.dart';

class ResumeController extends GetxController {
  DatabaseHelper db;
  ResumeController({required this.db});
  // Rx<Resume> resume = Resume(experiences: [], educations: [], languages: []).obs;
  RxList resumes = [].obs;

  Future<void> loadResumes() async {
    List<Resume> _resumes = await db.getResumes();
    print(_resumes);
  }

}
