import 'package:curriculum/core/providers/resume_provider.dart';
import 'package:curriculum/core/translations/app_translations.dart';
import 'package:curriculum/translations/codegen_loader.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:curriculum/screens/login.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await EasyLocalization.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ResumeProvider())
  ], child: EasyLocalization(
    fallbackLocale: const Locale('en'),
    supportedLocales: const [
      Locale('en'),
      Locale('pt'),
    ],
      assetLoader: const CodegenLoader(),
      path: 'assets/translations',
     child: const MyApp(),
  ),));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: AppTranslation(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
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
      home: LoginWidget(),
    );
  }
}
