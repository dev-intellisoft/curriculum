import 'package:curriculum/core/classes/resume.dart';
import 'package:curriculum/screens/resume/experiences.dart';
import 'package:curriculum/screens/resume/personal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  _ProfileWidget createState() => _ProfileWidget();
}

class _ProfileWidget extends State<ProfileWidget> {
  int _selectedIndex = 0;
  Resume resume = Resume();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _render(int index)  {
    if ( index == 1 ) {
      return ExperiencesWidget();
    }
    return PersonalWidget(resume: resume);
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
              label: 'Graduations',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ),
        body: _render(_selectedIndex),
      )
    );
  }

}
