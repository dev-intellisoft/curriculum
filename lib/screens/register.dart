import 'package:curriculum/core/classes/user.dart';
import 'package:curriculum/screens/resumes.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  _RegisterWidget createState() => _RegisterWidget();
}

class _RegisterWidget extends State<RegisterWidget> {
  bool visibility = false;
  String username = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    bool enabled = username.isNotEmpty && password.isNotEmpty;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset : true,
        appBar: AppBar( title: Text('register_screen.register'.tr()),),
          body: Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            child: SafeArea(
              child: ListView(
                children: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.orange[200],
                        border: Border.all(
                          color: Colors.orange,
                          width: 1.0,
                          style: BorderStyle.solid
                        )
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 40,
                              child: Icon(Icons.info_outline)
                          ),
                          SizedBox(
                            width: 280,
                            child: Column(
                              children: [
                                FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text('register_screen.text1'.tr()),
                                ),
                                FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text('register_screen.text2'.tr()),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    onChanged: (value){
                      setState(() {
                        username = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'username'.tr()
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    obscureText: !visibility,
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'password'.tr(),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            visibility = !visibility;
                          });
                        },
                        child: Icon(visibility?Icons.visibility_off:Icons.visibility)
                      )
                    ),
                  ),
                  const SizedBox(height: 20,),

                  GestureDetector(
                    onTap: enabled?() async {
                      if ( await User.register(username, password) ) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('register_screen.success'.tr()),
                          action: SnackBarAction(
                            label: '',
                            onPressed: () {},
                          ),
                        ));
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
                          return const ResumesWidget();
                        }));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('register_screen.failed'.tr()),
                          action: SnackBarAction(
                            label: '',
                            onPressed: () {},
                          ),
                        ));
                      }
                    }: () {},
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      width: double.infinity,
                      height: 45,
                      child: Center(
                        child: Text('register'.tr(), style: TextStyle(
                          color: enabled ?Colors.white:Colors.grey,
                          fontWeight: FontWeight.bold
                        ),)),
                      decoration: BoxDecoration(
                        color: enabled ? Colors.blueAccent:Colors.grey[300],
                        borderRadius: BorderRadius.circular(5)
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}
