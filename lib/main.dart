import 'package:curriculum/core/providers/resume_provider.dart';
import 'package:flutter/material.dart';
import 'package:curriculum/screens/login.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ResumeProvider())
  ], child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder()
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true
        ),
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.blueAccent,
          backgroundColor: Colors.white,
          elevation: 0
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginWidget(),
    );
  }
}
