import 'package:chemin_du_local/core/main_page/main_page.dart';
import 'package:chemin_du_local/theme/cl_theme.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Le Chemin du Local',
      theme: ClTheme.theme(context),
      home: const MainPage()
    );
  }
}