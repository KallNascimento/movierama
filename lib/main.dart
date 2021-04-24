import 'package:flutter/material.dart';
import 'package:movies/pages/home_page.dart';
import 'core/constant.dart';
import 'core/theme_app.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: kAppName,
      theme: kThemeApp,
      home: Moviepage(),
    );
  }
}
