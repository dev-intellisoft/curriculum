import 'package:curriculum/screens/settings/about.dart';
import 'package:curriculum/screens/settings/email.dart';
import 'package:curriculum/screens/settings/language.dart';
import 'package:curriculum/screens/settings/support.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreen createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const LanguageScreen();
                  }));
                },
                leading: const Icon(Icons.g_translate),
                title: const Text('Language', style: TextStyle(
                  fontWeight: FontWeight.bold
                ),),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const EmailScreen();
                  }));
                },
                leading: const Icon(Icons.email),
                title: const Text('E-mail', style: TextStyle(
                  fontWeight: FontWeight.bold
                ),),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_){
                    return const SupportScreen();
                  }));
                },
                leading: const Icon(Icons.support_agent),
                title: const Text('Support', style: TextStyle(
                    fontWeight: FontWeight.bold
                ),),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_){
                    return const AboutScreen();
                  }));
                },
                leading: const Icon(Icons.info_outline),
                title: const Text('About', style: TextStyle(
                  fontWeight: FontWeight.bold
                ),),
              )
            ],
          ),
        ),
      ),
    );
  }

}
