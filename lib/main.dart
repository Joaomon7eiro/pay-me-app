import 'package:flutter/material.dart';

import './pages/user_home_page.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'page nois',
      routes: {
        '/': (ctx) => UserHomePage(),
      },
    );
  }
}
