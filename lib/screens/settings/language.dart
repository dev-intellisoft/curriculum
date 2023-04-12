import 'package:curriculum/screens/resume/settings.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
// import 'package:provider/provider.dart';

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
        title: Text('settings_screen.languages_screen.title'.tr()),
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
        children: [
          TextButton(
            // color: Colors.blueGrey,
            onPressed: () {
              // context.read<LanguagesProvider>().setLocale(Locale('en'));
            },
            child: const Text('English')
          ),
          TextButton(
            // color: Colors.blueGrey,
            onPressed: () {
              // context.read<LanguagesProvider>().setLocale(Locale('pt'));
            },
            child: const Text('Português')
          )
        ],
      ),
    );
  }

}
