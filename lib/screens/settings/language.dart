import 'package:curriculum/screens/resume/settings.dart';
import 'package:flutter/material.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  _LanguageScreen createState() => _LanguageScreen();
}

class _LanguageScreen extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Language setting'),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context, MaterialPageRoute(builder: (_) {
                return const SettingsScreen();
              }));
            },
            child: Container(
              margin: const EdgeInsets.only(right: 15),
              child: const Icon(Icons.check),
            ),
          )
        ],
      ),
      body: const Center(
        child: Text('Languages'),
      ),
    );
  }

}
