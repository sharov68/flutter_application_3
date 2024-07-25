import 'package:flutter/material.dart';
import 'package:flutter_application_3/pages/login_page.dart';
//import 'package:flutter_application_3/pages/main_page.dart';
import 'package:flutter_application_3/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: DoDidDoneTheme.lightTheme,
      //home: const MainPage()
      home: const LoginPage(),
    );
  }
}
