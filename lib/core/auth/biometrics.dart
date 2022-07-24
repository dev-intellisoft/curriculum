import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth.dart';
final LocalAuthentication auth = LocalAuthentication();

enum SupportState {
  unknown,
  supported,
  unsupported,
}

Future<bool> checkBiometrics () async {
  return await auth.isDeviceSupported();
}

Future<bool> biometricLogin () async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  bool bioLogin = _prefs.getBool('biometric')??false;
  bool isSupported = await auth.isDeviceSupported();
  return bioLogin && isSupported;
}

Future<bool> isBiometricEnabled () async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  return _prefs.getBool('biometric')??false;
}

Future<bool> disabledBio() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  bool b = _prefs.getBool('biometric')??false;
  _prefs.setBool('biometric', !b);
  return !b;
}

Future<void> _checkBiometrics() async {
  late bool canCheckBiometrics;
  try {
    canCheckBiometrics = await auth.canCheckBiometrics;
  } on PlatformException catch (e) {
    canCheckBiometrics = false;
    print(e);
  }
}

Future<void> _getAvailableBiometrics() async {
  late List<BiometricType> availableBiometrics;
  try {
    availableBiometrics = await auth.getAvailableBiometrics();
  } on PlatformException catch (e) {
    availableBiometrics = <BiometricType>[];
    print(e);
  }
}

Future<bool> authenticate() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  bool authenticated = false;
  try {
    authenticated = await auth.authenticate(
      localizedReason: 'Let OS determine authentication method',
      options: const AuthenticationOptions(
        useErrorDialogs: true,
        stickyAuth: true,
      ),
    );

    if ( !authenticated ) {
      return false;
    }

    String _username = _prefs.getString('_username')??'';
    String _password = _prefs.getString('_password')??'';
    bool _login = await login(_username, _password);
    if ( !_login ) {
      _prefs.setBool('biometric', false);
      _prefs.setString('_username', _username);
      _prefs.setString('_password', _password);
    }
    return _login;
  } on PlatformException catch (e) {
    print(e);
    return false;
  }
}

Future<void> _authenticateWithBiometrics() async {
  bool authenticated = false;
  try {
    authenticated = await auth.authenticate(
      localizedReason:
      'Scan your fingerprint (or face or whatever) to authenticate',
      options: const AuthenticationOptions(
        useErrorDialogs: true,
        stickyAuth: true,
        biometricOnly: true,
      ),
    );
  } on PlatformException catch (e) {
    print(e);
    return;
  }
}
