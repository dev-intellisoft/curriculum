import 'package:curriculum/core/classes/user.dart';
import 'package:curriculum/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class LoginWidget extends StatefulWidget {
  bool? userExists;
  LoginWidget({
    Key? key,
    required this.userExists
  }) : super(key: key);

  @override
  _LoginWidget createState() => _LoginWidget();
}

class _LoginWidget extends State<LoginWidget> {
  String username = '';
  String password = '';
  bool visibility = false;

  void _init() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String? logged = _pref.getString('logged');
    if (logged == 'yes') {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return const HomeWidget();
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
                  child: const Text('openCV Builder', style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold
                  ),),
                ),

                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      username = value;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Username'
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
                    labelText: 'Password'
                  ),
                  obscureText: !visibility,
                ),

                const SizedBox(height: 15,),

                GestureDetector(
                  onTap: disabled?() {}:() async {
                    bool login = await User.login(username, password);
                    if ( login ) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.green,
                        content: const Text('Login success!'),
                        action: SnackBarAction(
                          label: '',
                          onPressed: () {},
                        ),
                      ));
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
                        return const HomeWidget();
                      }));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text('Something went wrong!'),
                        backgroundColor: Colors.red,
                        action: SnackBarAction(
                          label: '',
                          onPressed: () {},
                        ),
                      ));
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: double.infinity,
                    height: 45,
                    child:  Center(
                      child: Text('Login', style: TextStyle(
                        color: disabled?Colors.grey:Colors.white,
                        fontWeight: FontWeight.bold
                      ),)),
                    decoration: BoxDecoration(
                      color: disabled?Colors.grey[300]:Colors.blueAccent,
                      borderRadius: BorderRadius.circular(5)
                    ),
                  ),
                ),

                if ( widget.userExists != null && !widget.userExists! )
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
                      child: const Center(
                        child: Text('Register', style: TextStyle(
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
