import 'package:curriculum/screens/settings/about.dart';
// import 'package:curriculum/screens/settings/email.dart';
import 'package:curriculum/screens/settings/language.dart';
import 'package:curriculum/screens/settings/support.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

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
        title: Text('settings_screen.title'.tr()),
      ),
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
              const SizedBox(height: 15,),
              const Divider(),
              // ListTile(
              //   onTap: () {
              //     Navigator.push(context, MaterialPageRoute(builder: (_) {
              //       return const LanguageScreen();
              //     }));
              //   },
              //   leading: const Icon(Icons.g_translate),
              //   title: Text('settings_screen.languages'.tr(), style: const TextStyle(
              //     fontWeight: FontWeight.bold
              //   ),),
              // ),
              // const Divider(),
              ListTile(
                // onTap: () {
                //   Navigator.push(context, MaterialPageRoute(builder: (_) {
                //     return const EmailScreen();
                //   }));
                // },
                leading: const Icon(Icons.email),
                title: Text('settings_screen.email'.tr(), style: const TextStyle(
                  fontWeight: FontWeight.bold
                ),),
              ),
              const Divider(),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_){
                    return const SupportScreen();
                  }));
                },
                leading: const Icon(Icons.support_agent),
                title: Text('settings_screen.support'.tr(), style: const TextStyle(
                    fontWeight: FontWeight.bold
                ),),
              ),
              const Divider(),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_){
                    return const AboutScreen();
                  }));
                },
                leading: const Icon(Icons.info_outline),
                title: Text('settings_screen.about'.tr(), style: const TextStyle(
                  fontWeight: FontWeight.bold
                ),),
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }

}
