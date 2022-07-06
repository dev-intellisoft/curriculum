import 'package:curriculum/core/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final int? id;
  final String? username;
  final String? password;
  User({this.id, this.username, this.password});
  factory User.fromMap(Map<String, dynamic> json)
    => User(id: json['id'], username: json['username'], password: json['password']);

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'username': username,
      'password':password
    };
  }

  static Future<bool> login(String username, String password) async {
    return await DatabaseHelper.instance.login(User(username: username, password: password));
  }
  static Future<bool> register(String username, String password) async {
    try {
      SharedPreferences _pref = await SharedPreferences.getInstance();
      await DatabaseHelper.instance.addUser(User(username: username, password: password));
      _pref.setString('username', username);
      _pref.setString('logged', 'yes');
      return true;
    } catch (e) {
      return false;
    }
  }
}
