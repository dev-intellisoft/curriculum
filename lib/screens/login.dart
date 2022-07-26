import 'package:curriculum/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../core/auth/auth.dart';
import '../core/auth/biometrics.dart';
import '../widgets/biometric_alert.dart';
import 'resumes.dart';

class LoginWidget extends StatefulWidget {
  bool logout;
  LoginWidget({
    Key? key,
    this.logout = false
  }) : super(key: key);

  @override
  _LoginWidget createState() => _LoginWidget();
}

class _LoginWidget extends State<LoginWidget> {
  String username = '';
  String password = '';
  bool visibility = false;

   _init() async {
    if (await isLoggedIn()) {
      return Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return const ResumesWidget();
      }));
    }

    if (widget.logout) {
      return;
    }

    if ( await biometricLogin() && await authenticate() ) {
      return Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return const ResumesWidget();
      }));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    bool disabled = username.isEmpty || password.isEmpty;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset : true,
        body: Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          child: SafeArea(
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 60, bottom: 60),
                  child: Text('login_screen.app_name'.tr(), style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold
                  ),),
                ),

                TextFormField(
                  onTap: () async {
                    if ( await biometricLogin() ){
                      if (await authenticate() ) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
                          return const ResumesWidget();
                        }));
                      }
                    }
                  },
                  onChanged: (value) {
                    setState(() {
                      username = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'username'.tr()
                  ),
                ),

                const SizedBox(height: 15,),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                  decoration:  InputDecoration(
                    isDense: true,
                    suffix: GestureDetector(
                      onTap: () => {
                        setState(() {
                          visibility = !visibility;
                        })
                      },
                      child: visibility? const Icon(Icons.visibility_off): const Icon(Icons.visibility),
                    ),
                    labelText: 'password'.tr()
                  ),
                  obscureText: !visibility,
                ),

                const SizedBox(height: 15,),

                GestureDetector(
                  onTap: disabled?() {}:() async {
                    login(username, password).then((value) async {
                      if ( value ) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
                          return const ResumesWidget();
                        }));

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('login_screen.success'.tr()),
                          action: SnackBarAction(
                            label: '',
                            onPressed: () {},
                          ),
                        ));

                        if ( await isSupported() ) {
                          showDialog(context: context, builder: (ctx) => BiometricAlert(
                            onConfirm: () {
                              saveLoginCredentials(username, password);
                            },
                            onCancel: () {},
                          ),);
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('login_screen.failed'.tr()),
                          backgroundColor: Colors.red,
                          action: SnackBarAction(
                            label: '',
                            onPressed: () {},
                          ),
                        ));
                      }
                    }).catchError((e) {
                      print(e);
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: double.infinity,
                    height: 45,
                    child:  Center(
                      child: Text('login'.tr(), style: TextStyle(
                        color: disabled?Colors.grey:Colors.white,
                        fontWeight: FontWeight.bold
                      ),)),
                    decoration: BoxDecoration(
                      color: disabled?Colors.grey[300]:Colors.blueAccent,
                      borderRadius: BorderRadius.circular(5)
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return const RegisterWidget();
                    }));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: double.infinity,
                    height: 45,
                    child: Center(
                      child: Text('login_screen.register'.tr(), style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),)),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(5)
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
