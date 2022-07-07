import 'package:curriculum/core/classes/user.dart';
import 'package:curriculum/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        appBar: AppBar( title: const Text('Register'),),
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
                              children: const [
                                FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text('NOTE: All information will be kept on your device.'),
                                ),
                                FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text('Nothing is being shared through internet.'),
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
                    decoration: const InputDecoration(
                      labelText: 'Username'
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
                      labelText: 'Password',
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
                          content: const Text('Success'),
                          action: SnackBarAction(
                            label: '',
                            onPressed: () {},
                          ),
                        ));
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
                          return const HomeWidget();
                        }));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text('Something went wrong'),
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
                        child: Text('Register', style: TextStyle(
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
