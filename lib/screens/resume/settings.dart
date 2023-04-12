import 'package:curriculum/core/auth/biometrics.dart';
import 'package:curriculum/screens/settings/about.dart';
import 'package:curriculum/screens/settings/support.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import '../../core/auth/auth.dart';
import '../../core/providers/resume_provider.dart';
import '../../main.dart';
import '../login.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreen createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsScreen> {

  bool isBiometricSupported = false;
  bool isBioEnabled = false;
  _init () async {
    bool _isBiometricSupported = await checkBiometrics();
    bool _isBioEnabled = await isBiometricEnabled();
    setState(() {
      isBiometricSupported = _isBiometricSupported;
      isBioEnabled = _isBioEnabled;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('settings_screen.title'.tr),
      ),
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
              const SizedBox(height: 5,),
              const Divider(),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_){
                    return const AboutScreen();
                  }));
                },
                leading: const Icon(Icons.info_outline),
                title: Text('settings_screen.about'.tr, style: const TextStyle(
                    fontWeight: FontWeight.bold
                ),),
              ),
              const Divider(),
              ListTile(
                // onTap: () {
                //   Navigator.push(context, MaterialPageRoute(builder: (_) {
                //     return const EmailScreen();
                //   }));
                // },
                leading: const Icon(Icons.email),
                title: Text('settings_screen.email'.tr, style: const TextStyle(
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
                title: Text('settings_screen.support'.tr, style: const TextStyle(
                    fontWeight: FontWeight.bold
                ),),
              ),
              const Divider(),

              const SizedBox(height: 20,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: TextButton(
                  // minWidth: 200,
                  // color: Colors.grey,
                  // height: 47,
                  onPressed: () async {
                    await logout();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) =>
                        LoginWidget(logout:true)), (Route<dynamic> route) => false
                    );
                  },
                  child: Text('logout'.tr, style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),)
                ),
              ),

              if (isBiometricSupported)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: TextButton(
                    // height: 47,
                    // color: isBioEnabled?Colors.blueAccent:Colors.black12,
                    onPressed: () async {
                      bool b = await disabledBio();
                      setState(() {
                        isBioEnabled = b;
                      });
                    },
                    child: Text('',
                        // isBioEnabled?'settings_screen.disabled_biometric'.tr(namedArgs: {'type':'finger print'}):
                      // 'settings_screen.enabled_biometric'.tr(namedArgs: {'type':'finger print'}),
                      style: TextStyle(
                      color: isBioEnabled?Colors.white:Colors.grey,
                      fontWeight: FontWeight.bold
                    ),)
                  ),
                ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: TextButton(
                  onPressed: () {
                    showDialog(context: context, builder: (_) => AlertDialog(
                      title: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: const Icon(Icons.warning, color: Colors.orange,),
                          ),
                          Text('warning'.tr)
                        ],
                      ),
                      content: Text('delete_warning'.tr),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            bool remove = await context.read<ResumeProvider>().removeAccount();
                            if (remove) {
                              Navigator.pop(_);
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (context) =>
                                const MyApp()), (Route<dynamic> route) => false
                              );
                            }
                          },
                          child: Text('yes'.tr),
                          // color: Colors.red,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('no'.tr),
                          // color: Colors.grey.withOpacity(0.5),
                        )
                      ],
                    ),);
                  },
                  // height: 47,
                  // color: Colors.red,
                  child: Text('delete_my_account'.tr, style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
