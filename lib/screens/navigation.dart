import 'package:curriculum/core/classes/resume.dart';
import 'package:curriculum/core/common.dart';
import 'package:curriculum/core/providers/resume_provider.dart';
import 'package:curriculum/core/resume.dart';
import 'package:curriculum/screens/resume/educations.dart';
import 'package:curriculum/screens/resume/experiences.dart';
import 'package:curriculum/screens/resume/personal.dart';
import 'package:curriculum/screens/resume/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  _NavigationScreen createState() => _NavigationScreen();
}

class _NavigationScreen extends State<NavigationScreen> {
  ResumeController controller = Get.find<ResumeController>();

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    Resume resume = context.read<ResumeProvider>().getResume();
    if ( resume.name == '' || resume.name == null ) {
      showWarningMessage('navigation_screen.text1'.tr);
      return;
    }
    context.read<ResumeProvider>().saveResume(resume);
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _render(int index)  {
    if ( index == 1 ) {
      return const ExperiencesScreen();
    }
    if ( index == 2 ) {
      return const EducationsScreen();
    }
    if ( index == 3 ) {
      return const SettingsScreen();
    }
    return const PersonalWidget();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.account_box_rounded),
              label: 'navigation_screen.information'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.business),
              label: 'navigation_screen.experiences'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.school),
              label: 'navigation_screen.education'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: 'navigation_screen.settings'.tr,
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
        body: _render(_selectedIndex),
      )
    );
  }

}
