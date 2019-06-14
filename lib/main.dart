import 'package:flutter/material.dart';
import 'package:hua_rong_dao/view/home_page.dart';
import 'package:hua_rong_dao/controller/controller.dart';
import 'package:hua_rong_dao/view/login_page.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Controller controller = new Controller();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game',
      home: LoginPage(controller),
    );
  }
}