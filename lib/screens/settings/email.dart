import 'package:curriculum/screens/resume/settings.dart';
import 'package:flutter/material.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({Key? key}) : super(key: key);

  @override
  _EmailScreen createState() => _EmailScreen();
}

class _EmailScreen extends State<EmailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-mail Settings'),
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
      body: ListView(
        children: const [
          Text('Email settings')
        ],
      ),
    );
  }

}
