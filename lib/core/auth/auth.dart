import 'package:curriculum/core/classes/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> isLoggedIn () async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String? logged = _prefs.getString('logged');
  return logged == 'yes';
}

Future<bool> login(String username, String password) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  bool _login = await User.login(username, password);
  if ( _login ) {
    _prefs.setString('username', username);
    _prefs.setString('logged', 'yes');
  }
  return _login;
}

Future<void> logout() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  bool _bioLogin = _prefs.getBool('biometric')?? false;
  String _username = _prefs.getString('_username')??'';
  String _password = _prefs.getString('_password')??'';
  _prefs.clear();

  _prefs.setBool('biometric', _bioLogin);
  _prefs.setString('_username', _username);
  _prefs.setString('_password', _password);
}

Future<void> saveLoginCredentials(String username, String password) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.setString('_username', username);
  _prefs.setString('_password', password);
  _prefs.setBool('biometric', true);
}
