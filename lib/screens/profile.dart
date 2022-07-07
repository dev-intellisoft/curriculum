import 'package:curriculum/core/classes/resume.dart';
import 'package:curriculum/core/providers/resume_provider.dart';
import 'package:curriculum/screens/resume/educations.dart';
import 'package:curriculum/screens/resume/experiences.dart';
import 'package:curriculum/screens/resume/personal.dart';
import 'package:curriculum/screens/resume/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  _ProfileWidget createState() => _ProfileWidget();
}

class _ProfileWidget extends State<ProfileWidget> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    Resume resume = context.read<ResumeProvider>().getResume();
    if ( resume.name == '' || resume.name == null ) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.amber,
        content: Row(
          children:  [
            Container(
              margin: const EdgeInsets.only(right: 5),
                child:const Icon(Icons.warning_amber_outlined, color: Colors.black,)
            ),
            const Text('Please fill your information to proceed!', style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold),
            )
          ],
        ),
        action: SnackBarAction(
          label: '',
          onPressed: () {},
        ),
      ));
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
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.account_box_rounded),
              label: 'Personal',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Works',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'Education',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
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
